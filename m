Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267966AbTBZBQB>; Tue, 25 Feb 2003 20:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268532AbTBZBQB>; Tue, 25 Feb 2003 20:16:01 -0500
Received: from fwout.nihs.go.jp ([202.241.36.162]:52587 "EHLO smtp")
	by vger.kernel.org with ESMTP id <S267966AbTBZBQA>;
	Tue, 25 Feb 2003 20:16:00 -0500
Message-ID: <001b01c2dd36$1cfa8db0$f3c4b5cb@k768>
From: "Takuya Saitoh" <taka0038@yahoo.com>
To: "LKM" <linux-kernel@vger.kernel.org>
Subject: Kernel incompatibility with the SiS 651/962L architecture
Date: Wed, 26 Feb 2003 10:26:35 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am having this terrible problem of nonfunctional PCI devices with kernels
>= 2.4.19 and the SiS 651 chipset based system (motherboard Gigabyte P4
Titan GA-8SIMLH).  For example all NIC (onboard or PCI slot) cards are
recognized and configured just fine but timeout on transmit.  Another
example is a PCI SCSI card which reports errors of the sort "...
aic7xxx_abort returns 0x2002 ... device set offline ... command retry failed
after bus reset ..." upon module loading.  Is someone aware of this problem
and is there a patch ?  So far I have confirmed the same problem with
kernels 2.4.19-16mdk and 2.4.18-14 (yes, Mandrake 9.0 and RedHat 8.0 are
incompatible with this architecture) as well as 2.4.20-pre10-ac2.  This
problem doesn't occur with kernels from older distributions such as RedHat
7.3 (2.4.18-3) or 7.2.  There were some changes in the SiS architecture
around 2.4.18/19 (
http://marc.theaimsgroup.com/?l=linux-kernel&m=102804753309548&w=2 ) so may
that be the reason ?  There are also other reports of this problem, e.g.

From: rmkenn (rmkenn@email.de)
Subject: Suse 8.0 and GA-8SIMLH
This is the only article in this thread
View: Original Format
Newsgroups: alt.os.linux.suse
Date: 2002-12-06 09:13:03 PST

Hello,

I just got a new box, a Maxdata with P4. The mainboord is
a GA-8SIMLH with SiS 651 chipset.

My problem ist, that I can't bring my network cards to work.
The installation works fine, no error messages at boot-time,
but I can't get a 'ping' through. The cards have worked in an
elder box with SuSe 8.0. Could this be a issue with the motherboard?
I did not find it in SuSe's compatibilty database.

Any help would be appreciated,

Regards,

Rudolf.


