Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280024AbRKIS50>; Fri, 9 Nov 2001 13:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280021AbRKIS5P>; Fri, 9 Nov 2001 13:57:15 -0500
Received: from [62.144.170.218] ([62.144.170.218]:31238 "EHLO kommserv.eb.de")
	by vger.kernel.org with ESMTP id <S279997AbRKIS46>;
	Fri, 9 Nov 2001 13:56:58 -0500
Date: Fri, 9 Nov 2001 18:55:48 GMT
Message-Id: <200111091855.SAA27283@dix.eb.de>
From: Thomas Braun <nospam@link-up.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops/Aiee in 2.4.14 when unloading PCMCIA modules
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2001, Kevin wrote:
> The only difference with my setup is that it only seems to happen 
> if I eject both cards at the same time

Sorry, my mistake. The card is a combo card, ethernet and serial,
so maybe the setup is not so different. The "eject" unloads
both serial_cb and tulip_cb, then cb_enabler and the rest.
So it could be similar to ejecting 2 cards.

Regards,
Thomas
