Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268410AbTGTUta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268415AbTGTUta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:49:30 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:46225 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id S268410AbTGTUtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:49:24 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Date: Sun, 20 Jul 2003 22:04:31 +0100
Message-ID: <BKEGKPICNAKILKJKMHCAMEJJEPAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <1058294665.3845.61.camel@dhcp22.swansea.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan.

 >>>> Use HZ/2 instead.  GCC doesn't optimize floating point constants
 >>>> to the same degree it does integers, because it doesn't know what
 >>>> mode (rounding, precision) the FPU is in.

 >>> Isn't (HZ >> 1) better?

 >> Same thing. GCC knows that division by a power of 2 is just a shift.

 > Only for unsigned

When I did the "Assembler Language Maths Logic" module for my degree,
we learned that processors used SRL (Shift Right Logical) to divide
unsigned numbers by powers of 2, and SRA (Shift Right Arithmetic) to
divide signed numbers by powers of 2. Can't GCC handle that?

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.502 / Virus Database: 300 - Release Date: 18-Jul-2003

