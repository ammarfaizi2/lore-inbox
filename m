Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130163AbRAREEc>; Wed, 17 Jan 2001 23:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRAREEW>; Wed, 17 Jan 2001 23:04:22 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:19723 "HELO
	vanessa.roger.net") by vger.kernel.org with SMTP id <S130163AbRAREEP>;
	Wed, 17 Jan 2001 23:04:15 -0500
Date: Thu, 18 Jan 2001 02:04:08 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Cc: pgpkeys@hislinuxbox.com
Subject: Re: VIA chipset discussion
Message-ID: <20010118020408.A4713@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, pgpkeys@hislinuxbox.com
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Jan 17 2001, David D.W. Downey wrote:
> 
> Could those that were involved in the VIA chipset discussion email me
> privately at pgpkeys@hislinuxbox.com?

	Just to add a datapoint to the discussion, I'm using a VIA
	chipset here (in fact, it's an Asus A7V board with a Duron), a
	2.2.18 kernel with André's patches and I'm only using IDE
	(UDMA/66 and UDMA/33 here) and I'm *not* seeing any problems.

	Perhaps this may be a problem with some revisions of the
	chipset (or, perhaps, I'm not stressing my system enough for
	the bugs to show their heads).

	I'm attaching the output of lspci of my machine to this
	message.

	I also used a 2.4.0 kernel with all support for everything
	here enabled, but the HD where I had that kernel died. :-( So,
	I'm back using a 2.2.0 kernel.

> I'm truly interested in solving this issue. I personally think it's
> more than just the chipset causing the problems.

	This may be a possibility, since I'm using this very same
	chipset and I'm not seeing any problems...

> VIA chipset
> Promise controller (PDC2026# with specifics on the PDC20265 (ATA100))

	I'm using these (but I don't have anything in my Promise
	controller yet, since I couldn't find UDMA/100 drives when I
	bought my machine).

> SMP support
> IDE + SCSI mix in the system.

	But I'm not using SMP nor SCSI here.


	Hope this helps, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.txt"

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev 10)
00:0a.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01)
00:0d.0 Multimedia audio controller: Ensoniq: Unknown device 5880 (rev 02)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

--BOKacYhQ+x31HxR3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
