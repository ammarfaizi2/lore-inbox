Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVCNE6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVCNE6O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 23:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVCNE4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 23:56:19 -0500
Received: from fire.osdl.org ([65.172.181.4]:18825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261526AbVCNE4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 23:56:01 -0500
Date: Sun, 13 Mar 2005 20:55:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Stark <gsstark@mit.edu>
Cc: gsstark@mit.edu, s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
Message-Id: <20050313205531.442ddb77.akpm@osdl.org>
In-Reply-To: <87br9m7s8h.fsf@stark.xeocode.com>
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@mit.edu> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > I would agree with that.  If it's in the tree and the config system offers
> > it, it should work.  And if it _used_ to work, and no longer does so then
> > double bad.
> 
> Er, yeah, it's not like this is a new card that some crufty old driver never
> supported well. It worked fine in the past and got broke.
> 
> > Are you able to narrow it down to something more fine grained than "between
> > 2.6.6 and 2.6.9-rc1"?
> 
> Er, I suppose I would have to build some more kernels. Ugh. Is there a good
> place to start or do I have to just do a binary search?
> 

I'd suggest the first step would be to take the driver(s) from a working
kernel, put them into a current tree and see if things start working again.

If that doesn't reveal anything then yes, it's down to binary searching.


