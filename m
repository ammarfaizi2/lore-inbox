Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290769AbSAYShn>; Fri, 25 Jan 2002 13:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290730AbSAYSh3>; Fri, 25 Jan 2002 13:37:29 -0500
Received: from [198.17.35.35] ([198.17.35.35]:46294 "HELO mx1.peregrine.com")
	by vger.kernel.org with SMTP id <S290773AbSAYShM>;
	Fri, 25 Jan 2002 13:37:12 -0500
Message-ID: <B51F07F0080AD511AC4A0002A52CAB445B2AEC@ottonexc1.ottawa.loran.com>
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Machine Check Exception ?
Date: Fri, 25 Jan 2002 10:37:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used to get these all the time as well (with a very
similar hardware setup) and although I have never
identified exactly what was wrong (still using 2.2.x)
I don't get them any more after doing this :
1 - switched from IDE to SCSI
2 - changed RAM vendors (yes, this was unpleasant)
and, most significantly :
3 - made sure the BIOS had the correct microcode update
    for the CPU.  the one it had was out of date, and
    changing to the latest from Intel solved a LOT of
    instability issues....

> -----Original Message-----
> From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
> Sent: January 25, 2002 11:48
> To: Marcel Kunath
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Machine Check Exception ?
> 
> 
> On Fri, 25 Jan 2002 07:37:24 -0500 (EST)
> "Marcel Kunath" <kunathma@pilot.msu.edu> wrote:
> 
> > Whats the mobo?
> 
> Ok,here we go:
> 
> diehard:~ # lspci 
> 00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX 
> Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX 
> AGP bridge (rev 03)
> 00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> 00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> 00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly 
> NCR) 53c810 (rev 23)
> 00:0a.0 PCI bridge: Intel Corporation 80960RP [i960 RP 
> Microprocessor/Bridge] (rev 05)
> 00:0a.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
> 00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast 
> Etherlink] (rev 74)
> 01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 
> 3D/2X] (rev 02)
> 
> Regards,
> Stephan
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
