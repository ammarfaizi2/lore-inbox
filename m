Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUBIKNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 05:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbUBIKNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 05:13:54 -0500
Received: from [193.170.124.123] ([193.170.124.123]:57660 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264484AbUBIKNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 05:13:51 -0500
Date: Mon, 9 Feb 2004 11:13:31 +0100
From: JG <jg@cms.ac>
To: Lincoln Dale <ltd@cisco.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: TG3: very high CPU usage
In-Reply-To: <5.1.0.14.2.20040208105611.04710418@171.71.163.14>
References: <5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
	<20040125123154.A8CA4202CAA@23.cms.ac>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<20040119033527.GA11493@linux.comp>
	<20040119033527.GA11493@linux.comp>
	<5.1.0.14.2.20040121100550.03cff190@171.71.163.14>
	<5.1.0.14.2.20040122143222.02a06d68@171.71.163.14>
	<20040122125516.7B671202CDC@23.cms.ac>
	<5.1.0.14.2.20040125105347.02acce68@171.71.163.14>
	<20040125123154.A8CA4202CAA@23.cms.ac>
	<5.1.0.14.2.20040201110919.04788eb0@171.71.163.14>
	<5.1.0.14.2.20040208105611.04710418@171.71.163.14>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__9_Feb_2004_11_13_31_+0100_+DV_kediUndw6sax"
Message-Id: <20040209101349.8AAFF1A9AD5@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__9_Feb_2004_11_13_31_+0100_+DV_kediUndw6sax
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> good to hear.
> what revision BCM5700 was it that you had?
> 
> i've heard reports that the newer BCM5705s have 'issues' whereas 
> BCM5700-5703 are good.
> 
> can you post your 'lspci -vvv' output?

i'm sorry i can't tell the chip revision anymore (only card serial number) because i already RMA'ed the NIC.
i do have the same netgear card in another system where the serial number nearly identical (differs only by 1 digit), here's the lspci -vvv output:

00:09.0 Ethernet controller: Altima (nee Broadcom) AC9100 Gigabit Ethernet (rev 15)
        Subsystem: Netgear: Unknown device 302a
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (16000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at cffe0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
                Command: DPERE- ERO- RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-  Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
                Address: fc879f41878ba220  Data: 3f06


JG

--Signature=_Mon__9_Feb_2004_11_13_31_+0100_+DV_kediUndw6sax
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJ11dU788cpz6t2kRAphjAJ4uRjRaokZKveF6269JNxJ6dI7D7gCfcoTe
9e4ACI8vZfVxm1C4oprPHPM=
=QLf2
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Feb_2004_11_13_31_+0100_+DV_kediUndw6sax--
