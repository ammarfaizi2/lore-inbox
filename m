Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290862AbSBSJdc>; Tue, 19 Feb 2002 04:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290869AbSBSJdW>; Tue, 19 Feb 2002 04:33:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290862AbSBSJdD>; Tue, 19 Feb 2002 04:33:03 -0500
Subject: Re: Linux 2.4.18-pre9-mjc2
To: pavel@ucw.cz (Pavel Machek)
Date: Tue, 19 Feb 2002 09:47:15 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20020219092222.GA10247@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at Feb 19, 2002 10:22:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16d6rj-0008Pn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > computer" messages vanished about the time of the IBM/AT. You instructed
> > it to erase critical internal data, so it did.
> 
> I asked it to read temperature sensors *then* it commited suicide.

No. You load lm_sensors, it does a bus scan and that trashes your eeprom.
Its an lm_sensors problem (but rather hard to avoid when poking around
randomly inside a laptop without a clue what its doing)

> In such case disk should either:
> *) have "firmware flasher" part unwritable,
> or 
> *) check signature on whatever it is flashing in, and if it does not
> match, refuse to flash it. 

Well they don't.
