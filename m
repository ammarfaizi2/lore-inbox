Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273213AbRKXLoH>; Sat, 24 Nov 2001 06:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRKXLns>; Sat, 24 Nov 2001 06:43:48 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:4480 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S273213AbRKXLno>; Sat, 24 Nov 2001 06:43:44 -0500
Message-ID: <005301c174dc$d25ad5c0$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
        "lkml" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10111232239100.32407-100000@master.linux-ide.org> <00de01c174c6$d4d092b0$0201a8c0@HOMER>
Subject: ATA is not crap. Propably.
Date: Sat, 24 Nov 2001 12:40:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry everyone I've upset.

The problem *seems* to be with my hard disks. Apparently both advertises
udma2 capability but neither is capable?? When I run the disks on my
"on-board" controller, I get a DMA timeout and the system comes to a halt
(well only the HD activity, but you can't do much without access to the
root/usr partition). When running on my HPT366 controller, I don't get the
timeouts, but I do get the "slow responding system" at about the same time
at which I get the timeouts on the PIIX4 controller. Problem comes when
having copied about 11% of a 500'000'000 byte file from /dev/hdc7 to
/dev/hda6...

The hard disks in question are models
hda: ST36451A
hdc: Maxtor 91152D8

The reason why I moved to the HPT366 controller in the first place, was
because the onboard controller / BIOS? messed up the C/H/S values on one of
the hard disks. Cannot be 100% sure though as this was a while ago (two
years?).

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


