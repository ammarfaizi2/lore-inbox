Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135476AbRAJRC3>; Wed, 10 Jan 2001 12:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133048AbRAJRCT>; Wed, 10 Jan 2001 12:02:19 -0500
Received: from mail.barryscott.com ([216.207.134.34]:64265 "HELO
	mail.barryscott.com") by vger.kernel.org with SMTP
	id <S135476AbRAJRCI>; Wed, 10 Jan 2001 12:02:08 -0500
Message-Id: <5.0.2.1.2.20010110115935.00a44bb0@mail.barryscott.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Wed, 10 Jan 2001 12:02:34 -0500
To: linux-kernel@vger.kernel.org
From: Mike Lieman <os-support@barryscott.com>
Subject: 2.4.0 serial.c PCI_CONFIG v. 2.2.18 serial.c w/o PCI_CONFIG
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed something weird when I tried to minicom into the office to run 
a job yesterday morning.

It seems that 2.2.18 (without the PCI_CONFIG in serial.c) works fine, with 
respect to flow control in minicom, everything looks great.  (and the dmesg 
shows the serial ports without any extra flags.  PLAIN VANILLA!), but under 
2.4.0, all the extended stuff is turned on by PCI_CONFIG, and characters 
are being dropped!

Anyone else experiencing this?

peace
Mike


-=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=--=*=-
Mike Lieman -- CIO                           mikelieman@barryscott.com
The Barry Scott Companies                      (518) 452-8560 ext. 114

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
