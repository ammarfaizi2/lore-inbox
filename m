Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274857AbTHPWdB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274975AbTHPWdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 18:33:01 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:31239 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S274857AbTHPWc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 18:32:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: Martin List-Petersen <martin@list-petersen.se>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: Centrino support
Date: Sun, 17 Aug 2003 01:32:50 +0300
X-Mailer: KMail [version 1.4]
Cc: Christian Axelsson <smiler@lanil.mine.nu>, linux-kernel@vger.kernel.org
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060980941.29086.25.camel@serpentine.internal.keyresearch.com> <1060982549.15347.30.camel@loke>
In-Reply-To: <1060982549.15347.30.camel@loke>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308170132.50312.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Got a list of supported good working cards?
> >
> > There's a Dell TrueMobile card that uses the Orinoco chipset.  If you're
> > feeling like life is too boring, there are cards based on the newer
> > Intersil dual 802.11b/g chipsets available, too, and though I haven't
> > checked into the shape of the drivers, I know they're under active
> > development.
>
> The Dell TrueMobile 1150 series are Agere/Orinoco/Hermes based (MiniPCI
> and PC-Card available). All other Dell TrueMobile cards are Broadcom
> based and have no Linux driver support either.
>
> There are also MiniPCI, PC-Card, USB adapters with 802.11a/b/g and Linux
> drivers available: http://sf.net/projects/madwifi

That driver contains a binary-only part.

<quote>
The ath_hal module contains the Atheros Hardware Access Layer (HAL).
This code manages much of the chip-specific operation of the driver.
The HAL is provided in a binary-only form in order to comply with FCC
regulations.  In particular, a radio transmitter can only be operated at
power levels and on frequency channels for which it is approved.  The FCC
requires that a software-defined radio cannot be configured by a user
to operate outside the approved power levels and frequency channels.
This makes it difficult to open-source code that enforces limits on
the power levels, frequency channels and other parameters of the radio
transmitter.  See

http://ftp.fcc.gov/Bureaus/Engineering_Technology/Orders/2001/fcc01264.pdf

for the specific FCC regulation.  Because the module is provided in a
binary-only form it is marked "Proprietary"; this means when you load
it you will see messages that your system is now "tainted".
</quote>

US was a free country. It gets worse by the day.
-- 
vda
