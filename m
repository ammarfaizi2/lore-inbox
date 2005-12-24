Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVLXT6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVLXT6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 14:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVLXT6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 14:58:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750700AbVLXT6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 14:58:10 -0500
Date: Sat, 24 Dec 2005 11:57:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
In-Reply-To: <43AD726A.5010703@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0512241155250.14098@g5.osdl.org>
References: <43AD4ADC.8050004@colorfullife.com> <43AD64AB.2070306@pobox.com>
 <43AD726A.5010703@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Dec 2005, Manfred Spraul wrote:
> 
> > 2) I have requested multiple times that you avoid MIME...
> 
> It's the first time that you complain about Content-Transfer-Encoding: 7bit
> attachments.

These proper text encodings are easy to _apply_, because the raw email is 
uncorrupted. 

However, attachments are still broken for a very fundamental reason: 
basically no email client will ever quote them on replies. Which means 
that if somebody has commentary about some specific part of the patch, the 
attachement is _totally_ the wrong thing to do.

In other words, there's a reason I encourage people VERY STRONGLY to use 
in-line patches. If you have a broken mailer that corrupts whitespace, 
please just fix it.

		Linus
