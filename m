Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWGTUbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWGTUbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 16:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWGTUbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 16:31:12 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:33256 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964892AbWGTUbL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 16:31:11 -0400
Subject: Re: Status of the T-Mobile 3G PCMCIA Card
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Lothian <mike@fireburn.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fc94aae90607201140m6d50b8d0qa547a93e14babb66@mail.gmail.com>
References: <fc94aae90607201140m6d50b8d0qa547a93e14babb66@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 22:28:55 +0200
Message-Id: <1153427335.2772.4.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> I've recently subscribed to T-Mobile's 3G service for my laptop. I
> found v little info on the card but heard a few success stories with
> the Vodafone card with Linux.
> 
> Upon getting the card I've not realised my mistake and it appears that
> it isn't as simple as I'd hoped.
> 
> Has anyone had any success with this card at all?
> 
> The lspci out put is:
> 
> 04:00.2 Network controller: Option N.V. Qualcomm MSM6275 UMTS chip
>         Flags: medium devsel, IRQ 17
>         Memory at 52040000 (32-bit, non-prefetchable) [disabled] [size=2K]
> 04:00.2 0280: 1931:000c
> 
> pccard: CardBus card inserted into slot 0 is what dmesg says
> 
> And nothing appears under lsusb
> 
> I'd be grateful for any help anyone can offer because if I can't get
> it to work I'll need to return it within the "cooling down" period
> which is the next few days and be locked into an 18 month contract

they provided a driver for it and I am working on cleaning it up and
getting it merged mainline, but this hasn't been finished now. However I
am using this card for quite some time now with Linux. You can download
my current driver version with this command:

	cg-clone http://git.holtmann.org/nozomi.git

I broke the latest revision with a change that produces a NULL pointer
dereference and haven't had the time to fix it. Will take a look at it
once I am back from the OLS.

Regards

Marcel


