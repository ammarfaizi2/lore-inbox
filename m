Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUJIBHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUJIBHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 21:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUJIBHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 21:07:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:36269 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266459AbUJIBGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 21:06:53 -0400
Subject: Re: [PATCH] amd8111e endian & barrier fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       khawar.chaudhry@amd.com, reeja.john@amd.com
In-Reply-To: <m3u0t5a0u1.fsf@averell.firstfloor.org>
References: <2MWTy-5mO-5@gated-at.bofh.it>
	 <m3u0t5a0u1.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1097283973.3605.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 11:06:13 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 21:47, Andi Kleen wrote:

> It's basically impossible to review the patch properly because
> of that change. Can you please separate the arbitary white space
> change into a different patch? 

Hrm... I think you are doing too much here ;) The change concerns only a
single function and is still quite readable :) But anyways, I'll
eventually do that next week.

> Also I would suggest you send the patch to the driver 
> maintainers for review first (cc'ed) 

Well, I would have done if any maintainer email was in the source code,
which isn't the case, but thanks for providing them :)

> >From a quick look the change to clear the ring rx flags completely
> instead of clearing the bit looks bogus. Why did you not just add a
> endian conversion there?

Because the bits mask was ... 0 :)

> I can test it when it's properly reviewd.

Sure. No hurry.

Ben

