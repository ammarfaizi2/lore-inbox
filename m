Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSAWKUG>; Wed, 23 Jan 2002 05:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289772AbSAWKTy>; Wed, 23 Jan 2002 05:19:54 -0500
Received: from danielle.hinet.hr ([195.29.148.143]:43926 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S289769AbSAWKTg>; Wed, 23 Jan 2002 05:19:36 -0500
Date: Wed, 23 Jan 2002 11:19:34 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: i810 TCO ?!
Message-ID: <20020123111934.C9441@danielle.hinet.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to use i810 watchdog module (i810-tco).

Upon modprobing I get ->

kernel: i810 TCO timer: failed to reset NO_REBOOT flag, reboot disabled by hardware

what should I do now ?

 - add some options to insmod ?
 - change some option in BIOS (I can't pinpoint any)
 - change some jumper onboard ?
 - apply some patch ?


driver is 0.03 posted on this list in Oct last year.
Kernel is latest 2.4.x (currently 18-pre4).

lspci ->

# lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset Graphics Controller]  (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 02)
00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 02)
00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 02)
00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 02)
00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801BA(M) AC'97 Audio (rev 02)
01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 01)

any other information available on request,


TIA,

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
