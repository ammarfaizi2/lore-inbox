Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264726AbRFQMbR>; Sun, 17 Jun 2001 08:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264731AbRFQMbH>; Sun, 17 Jun 2001 08:31:07 -0400
Received: from ucu-105-116.ucu.uu.nl ([131.211.105.116]:61252 "EHLO
	ronald.bitfreak.net") by vger.kernel.org with ESMTP
	id <S264726AbRFQMau>; Sun, 17 Jun 2001 08:30:50 -0400
From: "Ronald Bultje" <rbultje@ronald.bitfreak.net>
To: <linux-kernel@vger.kernel.org>
Subject: a memory-related problem?
Date: Sun, 17 Jun 2001 14:37:03 +0200
Message-ID: <CDEJIPDFCLGDNEHGCAJPOEFGCCAA.rbultje@ronald.bitfreak.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just added 128 MB of RAM to my machine which already had 128 MB and
which has 128 MB swap. 128 MB RAM + 128 MB swap (either the new or the
old 128 MB RAM) works, but the combination of that, 256 MB RAM + 128 MB
swap, crashes the compu during startup with either an "unresolved-
symbols in init" message (which is completely random, each boot shows
different unresolved references) or with oopses right after starting
init.

(btw is it useful to write down these oopses on paper, reboot with
only 128 MB RAM to ksymoops them?)

Any idea on what's wrong? I thought the memory could be broken but
when booting with only the new memory in the machine, it does startup
so I suppose the memory itself is okay (but I'm not a hardware expert). 
Or is this "normal behaviour" when a machine doesn't follow swap=2xRAM? 
(and then again, why did it startup with 128MB/swap?)

distro = RedHat-7.0 (with updates from redhat.com installed)
Kernel = 2.4.4
gcc = 2.96
glibc = 2.2

system = p-II 400 MHz, 128 MB swap, 440BX (abit p6b) mainboard
memory is (133 MHz) SDRAM memory (running at 100 MHz)

[please CC me, I'm currently not subscribed]

Regards,

Ronald Bultje

