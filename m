Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316683AbSG1Ncj>; Sun, 28 Jul 2002 09:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSG1Ncj>; Sun, 28 Jul 2002 09:32:39 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:10959 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S316683AbSG1Nci>;
	Sun, 28 Jul 2002 09:32:38 -0400
Date: Sun, 28 Jul 2002 08:30:12 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: [idehardware] IDE problem tracking
Message-ID: <Pine.LNX.4.44.0207280801290.15122-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sat, 27 Jul 2002, Linus Torvalds wrote:
>>
>> I'm talking about people who don't even bother to do
>> bug-reports, but only trash-talk the maintenance.
>
>On that note, let me mention the machines I personally am using IDE, and
>apparently do not see problems: a dual PII with "Intel Corp. 82371AB 
>PIIX4
>IDE", and a P4 with "SiS 5513 IDE (rev 208)".
>
>Both setups in DMA mode, both setups have one disk per channel (first
>channel is disk, second channel is CD-ROM).
>
>So what are the patterns for "working" vs "broken"?

If this is viewed as a configuration-related issue, I'll volunteer to 
collect the "working" vs "broken" configurations.  If you want to 
participate please send me the output of lspci -v, /proc/cpuinfo, 
motherboard and bios identification, IDE revision version, and kernel 
version.  Also, please enumerate what devices are on each IDE channel.

Since this is aimed at helping Linus and Martin, please use the "standard" 
IDE code.  I believe 2.5.29 is up to IDE version IDE-107.  Let's start 
with that as a base.

