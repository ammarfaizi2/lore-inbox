Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbVLNTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbVLNTRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 14:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbVLNTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 14:17:32 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:50836 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964896AbVLNTRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 14:17:31 -0500
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org, Sridhar Samudrala <sri@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <43A04A38.6020403@us.ibm.com>
References: <439FCECA.3060909@us.ibm.com>
	 <20051214100841.GA18381@elf.ucw.cz> <20051214120152.GB5270@opteron.random>
	 <1134565436.25663.24.camel@localhost.localdomain>
	 <43A04A38.6020403@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 14 Dec 2005 19:17:06 +0000
Message-Id: <1134587827.25663.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-12-14 at 08:37 -0800, Matthew Dobson wrote:
> Actually, Sridhar's code (mentioned earlier in this thread) *does* drop
> incoming packets that are not 'critical', but unfortunately you need to

I realise that but if you look at the previous history in 2.0 and 2.2
this was all that was ever needed. It thus begs the question why all the
extra support and logic this time around ?

