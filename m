Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281854AbSAAPQj>; Tue, 1 Jan 2002 10:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbSAAPQ1>; Tue, 1 Jan 2002 10:16:27 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:23219 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S281762AbSAAPQN>;
	Tue, 1 Jan 2002 10:16:13 -0500
Date: Tue, 1 Jan 2002 16:16:07 +0100
From: Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: zImage not supported for 2.2.20?
Message-ID: <20020101161607.A16282@upset.pdb.fsc.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1> <4.3.2.7.2.20011228124704.00abba70@192.168.124.1> <20011228163250.A31791@elektroni.ee.tut.fi> <20011228211348.A8720@upset.pdb.fsc.net> <a0j9fh$tjn$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a0j9fh$tjn$1@cesium.transmeta.com>; from hpa@zytor.com on Fri, Dec 28, 2001 at 06:23:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2001 at 06:23:45PM -0800, H. Peter Anvin wrote:
> > 
> > Loading linux 2.2.20.......
> > Uncompressing Linux...
> > 
> > Out of memory
> > 
> >  -- System halted
> > 
> > Siemens/Nixdorf Mobile 710
> > Pentium MMX 166MHz, 128MB
> > 
> > Kernel 2.2.20 generated from perfectly running 2.2.19 with
> > make oldconfig; make dep; make zImage; ...
> > 
> > 2.4.16 does not work too:
> > Loading linux 2.4.16........
> > 
> > [ black screen and than back in BIOS-boot ]
> > 
> 
> Chipset info?  BIOS info?
> 
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
00:01.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
00:01.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:01.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:01.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
00:06.0 VGA compatible controller: Chips and Technologies F65554 (rev c2)
00:14.0 CardBus bridge: Cirrus Logic PD 6832 (rev c1)
00:14.1 CardBus bridge: Cirrus Logic PD 6832 (rev c1)

PhoenixBIOS 4.0 RELEASE 5.1
BIOS REALEASE VERSION 3D24
Build Time: 09/07/98 15:01:24

> Also, is there any connection between this box and the Toshiba Tecra
> 710 (since they have similar type numbers?)

Likely this box is not built by Siemens/Nixdorf (only packaging and label)
so this is possible. I will try to find out,

	Wolfgang
