Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTEODfd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 23:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263848AbTEODeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 23:34:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8973 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263847AbTEODda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 23:33:30 -0400
Date: Wed, 14 May 2003 20:45:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: ch@murgatroid.com, <inaky.perez-gonzalez@intel.com>, <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <20030514183925.67a538fc.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0305142043150.28644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Andrew Morton wrote:
> 
> I did it the below way.  Or are you suggesting that a manual edit of
> .config should be required? 

Yes. The same way MMU, UID16 and GENERIC_ISA_DMA is always true on x86. 
You could make it false on some other architecture where it might make 
sense.

		Linus

