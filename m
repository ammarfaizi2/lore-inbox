Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287196AbSACMXC>; Thu, 3 Jan 2002 07:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287199AbSACMWw>; Thu, 3 Jan 2002 07:22:52 -0500
Received: from wiproecmx1.wipro.com ([164.164.31.5]:18050 "EHLO
	wiproecmx1.wipro.com") by vger.kernel.org with ESMTP
	id <S287196AbSACMWj>; Thu, 3 Jan 2002 07:22:39 -0500
From: "BALBIR SINGH" <balbir.singh@wipro.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <esr@thyrsus.com>
Cc: "David Woodhouse" <dwmw2@infradead.org>, "Dave Jones" <davej@suse.de>,
        "Lionel Bouton" <Lionel.Bouton@free.fr>,
        "Linux Kernel List" <linux-kernel@vger.kernel.org>
Subject: RE: ISA slot detection on PCI systems?
Date: Thu, 3 Jan 2002 17:37:51 +0530
Message-ID: <AAEGIMDAKGCBHLBAACGBMEMNCCAA.balbir.singh@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-18bb588e-0042-11d6-a940-00b0d0d06be8"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <E16M6qn-00088Y-00@the-village.bc.nu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-18bb588e-0042-11d6-a940-00b0d0d06be8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

|> So you're saying the users should be completely lost any time they want
|> to use an upated kernel?
|
|Quite honestly if you want a user built "update" kernel it should probably
|work out the critical stuff (CPU, memory size limit, SMP) set a few things
|to safe values, and build all the driver modules.
|
|Why ask the user at all. The boot process already knows what
|modules to load
|Instead you get
|
|	Checking...
|		This is an X86 platform
|		You have an AMD K6 processor
|		Your machine lacks SMP support
|		You have 256Mb of memory
|
|	I am building you a kernel for an AMD K6 series processor with
|	up to 1Gb of memory and no SMP. If you add more than 1Gb of memory
|	you will need to build a new kernel

This would break things like cross-compilation. Not sure how many people
use it though. You will have to be on the machine for which you intend
to compile the kernel. If you are compiling the kernel for the same machine
then it is the best thing to happen, provided the software doing the
configuration for u is not broken

Balbir


------=_NextPartTM-000-18bb588e-0042-11d6-a940-00b0d0d06be8
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

-----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
------------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-18bb588e-0042-11d6-a940-00b0d0d06be8--
