Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVB1LCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVB1LCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 06:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVB1LCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 06:02:19 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:37079 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261454AbVB1LCO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 06:02:14 -0500
Date: Mon, 28 Feb 2005 12:00:28 +0100 (CET)
To: pasik@iki.fi
Subject: Re: [RFT] Preliminary w83627ehf hardware monitoring driver
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <BIe4VCVx.1109588428.5008080.khali@localhost>
In-Reply-To: <20050228075012.GN25818@edu.joroinen.fi>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LM Sensors" <sensors@Stimpy.netroedge.com>,
       "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pasi,

> > Have you tried w83627hf_wdt? I took a quick look at the W83627HF and
> > W83627THF datasheets and watchdog timer seems to work identically. Since
> > the driver doesn't seem to identify the chip (it probably should, BTW),
> > I'd expect it to work.
>
> Yes, I have tried it. It doesn't work.
>
> The machine reboots always after the watchdog timeout set in the BIOS. I've
> tried with the example watchdog daemon from the watchdog.txt, and with the
> Debian "watchdog" package.
>
> When I enable the debug messages and logging in the Debian watchdog
> package, I can see that the watchdog daemon gets stuck while trying to
> update the /dev/watchdog.. so the driver hangs..

I am not familiar with watchdogs. I'd invite you to get in touch with
the author and/or maintainer of the w83627hf_wdt driver, or possibly try
to debug it yourself. Datasheets are freely available from Winbond for
both the W83627HF and W83627THF:
  http://www.winbond.com/e-winbondhtm/partner/b_2_d_2.htm

I do not own a system with either chip myself, so I can hardly help. (If
anyone wants to donate a system with either chip so that I can work on
this, just contact me.)

--
Jean Delvare
