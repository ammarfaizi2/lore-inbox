Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVBRPnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVBRPnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVBRPn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:43:27 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:40114 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261392AbVBRPnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:43:18 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Dan Dennedy <dan@dennedy.org>
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Date: Fri, 18 Feb 2005 10:42:46 -0500
User-Agent: KMail/1.7.92
Cc: Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
References: <41FD498C.9000708@comcast.net> <1108180477.30605.7.camel@localhost.localdomain> <1108740772.4588.3.camel@kino.dennedy.org>
In-Reply-To: <1108740772.4588.3.camel@kino.dennedy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502181042.47404.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2005 10:32 am, Dan Dennedy wrote:
> I have tested the patches (including for allocation), and it is working
> great, but should I only commit for now the deallocation patch? Hmm..
> which is worse the debug or the 200K waste?
Thanks for following it up.

IMHO, we should commit both patches for now since we don't have an alternative 
solution yet. 

Jody - Is the 200K waste for sure or do you want me to verify it by some 
means? ( Reason I am asking is firstly, Dave Brownell was quite sure it 
wasn't that costly and secondly, I am hoping it isn't.. ;)

Parag
