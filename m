Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbSBKCWD>; Sun, 10 Feb 2002 21:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286339AbSBKCVy>; Sun, 10 Feb 2002 21:21:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13577 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286322AbSBKCVr>; Sun, 10 Feb 2002 21:21:47 -0500
Subject: Re: Problem with I2O block Driver in 2.4.17 and 2.4.18-pre9
To: tkhoadfdsaf@hotmail.com (T. A.)
Date: Mon, 11 Feb 2002 02:35:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <OE46xJO7Z6KTi1P6SM500013d46@hotmail.com> from "T. A." at Feb 10, 2002 09:13:35 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16a6JU-0005Co-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Is there a known bug in the I2O drivers (probably block) included in the
> current 2.4.17 and 2.4.18-pre9 kernels?

Its a known problem. Use the Red Hat kernel tree for now and all will be
well. I've spent some time working on this and after a long false trail caused
by what appear to be very very nasty bios bugs in the ASUS AM7-266D mainboard
I think I have the i2o_block and i2o_core problems sorted for x86, at least
on the FC920 and Promise cards I have for testing. i2o_scsi I have some thinking
left to do and may not be able to fix because it works on my cards and fails
on some others.

Fixing i2o for 2.5 is a major undertaking and I don't plan to address that
until close to the point 2.5 is frozen for a new stable release.

Alan
