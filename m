Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273403AbRINOwB>; Fri, 14 Sep 2001 10:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273404AbRINOvv>; Fri, 14 Sep 2001 10:51:51 -0400
Received: from danielle.hinet.hr ([195.29.254.157]:7810 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S273403AbRINOvl>; Fri, 14 Sep 2001 10:51:41 -0400
Date: Fri, 14 Sep 2001 16:51:46 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mario Mikocevic <mozgy@hinet.hr>, linux-kernel@vger.kernel.org
Subject: Re: v2410p8 and v2410p9 are no go
Message-ID: <20010914165146.A6088@danielle.hinet.hr>
In-Reply-To: <20010914134415.A802@danielle.hinet.hr> <E15hrsF-00006s-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15hrsF-00006s-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Sep 14, 2001 at 01:15:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > kernels 2.4.10-pre8 and 2.4.10-pre9 are NoGo for me,
> > last kernel I tried and it still runs succesfully is 2.4.10-pre4.
> > 
> > dmesg difference is ->
> > 
> > - hda: [PTBL] [5171/240/63] hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
> > - hdd: [PTBL] [787/128/63] hdd1
> > + hda: no partitions found
> > + hdd: no partitions found
> > 
> 
> What IDE chipset are you using.  Also do you have ACPI enabled and if so
> does it work if you dont compile that in ?

# lspci
00:00.0 Host bridge: Intel Corporation 82850 850 (Tehama) Chipset Host Bridge (MCH) (rev 02)
00:01.0 PCI bridge: Intel Corporation 82850 850 (Tehama) Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82820 820 (Camino 2) Chipset PCI (rev 04)
00:1f.0 ISA bridge: Intel Corporation 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 04)
00:1f.1 IDE interface: Intel Corporation 82820 820 (Camino 2) Chipset IDE U100 (rev 04)
00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 04)
00:1f.3 SMBus: Intel Corporation 82820 820 (Camino 2) Chipset SMBus (rev 04)
00:1f.5 Multimedia audio controller: Intel Corporation: Unknown device 2445 (rev 04)
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144
02:09.0 Multimedia audio controller: Unknown device 5046:1001 (rev 01)
02:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 6c)

# grep ACPI /usr/src/linux/.config
CONFIG_ACPI=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUSMGR=y
CONFIG_ACPI_SYS=y
CONFIG_ACPI_CPU=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_EC is not set
# CONFIG_ACPI_CMBATT is not set
# CONFIG_ACPI_THERMAL is not set


will try without ACPI ..

-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
