Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261834AbVCQUJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261834AbVCQUJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 15:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVCQUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 15:09:18 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:41560 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261834AbVCQUIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 15:08:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=QdTlRgCnX9eucyvkVSBkvvPRTJT1g1O0lAyCBx7o8ZhloGy/k82PYJIVg+eVln7/BAueb0JiKoYKx/+3GidqAsZyNFH1HHmoMZrJ3r89vLaKYq/PXEbHil+TUlpz4rr+nyFTcrna0xIWVRz9Qmmvgu3tdsBhxwTs04Ot6eOCjqM=
Message-ID: <5a2cf1f605031712062bc90d09@mail.gmail.com>
Date: Thu, 17 Mar 2005 21:06:59 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH][1/2] SquashFS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7vmzt4pdf9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <4235BAC0.6020001@lougher.demon.co.uk>
	 <20050315003802.GH3163@waste.org> <42363EAB.3050603@yahoo.com.au>
	 <20050315004759.473f6a0b.pj@engr.sgi.com>
	 <42370442.7020401@lougher.demon.co.uk>
	 <20050315172724.GO32638@waste.org>
	 <42370B14.50608@lougher.demon.co.uk>
	 <20050315110632.07fc8d09.pj@engr.sgi.com>
	 <7vmzt4pdf9.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Mar 2005 17:50:02 -0800, Junio C Hamano <junkio@cox.net> wrote:
> >>>>> "PJ" == Paul Jackson <pj@engr.sgi.com> writes:
> 
> PJ> There is not a concensus (nor a King Penguin dictate) between the
> PJ> "while(1)" and "for(;;)" style to document.
> 
> FWIW, linux-0.01 has four uses of "while (1)" and two uses of
> "for (;;)" ;-).
> 
> ./fs/inode.c:   while (1) {
> ./fs/namei.c:   while (1) {
> ./fs/namei.c:   while (1) {
> ./kernel/sched.c:       while (1) {
> 
> ./init/main.c:  for(;;) pause();
> ./kernel/panic.c:       for(;;);
> 
> What is interesting here is that the King Penguin used these two
> constructs with consistency.  The "while (1)" form was used with
> normal exit routes with "if (...) break" inside; while the
> "for(;;)" form was used only in unusual "the thread of control
> should get stuck here forever" cases.
> 
> So, Phillip's decision to go back to his original while(1) style
> seems to be in line with the style used in the original Linux
> kernel ;-).

After the Pinguin janitors, now comes the Pinguin archeologists.

This starts to be lemmingesque :)

J
