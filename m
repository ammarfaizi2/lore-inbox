Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281255AbRK0Pwj>; Tue, 27 Nov 2001 10:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRK0Pwa>; Tue, 27 Nov 2001 10:52:30 -0500
Received: from pd32.jeleniag.cvx.ppp.tpnet.pl ([213.77.236.32]:36868 "HELO
	marek.almaran.home") by vger.kernel.org with SMTP
	id <S281255AbRK0PwM> convert rfc822-to-8bit; Tue, 27 Nov 2001 10:52:12 -0500
Subject: Re: "spurious 8259A interrupt: IRQ7"
From: Marek =?iso-8859-13?Q?P=E6tlicki?= <marpet@linuxpl.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3511.10.119.8.1.1006856832.squirrel@extranet.jtrix.com>
In-Reply-To: <3511.10.119.8.1.1006856832.squirrel@extranet.jtrix.com>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 27 Nov 2001 14:14:41 +0100
Message-Id: <1006866892.5986.9.camel@marek.almaran.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin A. Brooks wrote:
> I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
> according to /proc/pci.
> 
> Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.

same thing here:

1GHz Athlon TB (currently on 900MHz due to stability problems), 128MB
DDR SDRAM

$ lspci
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3099
00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b099
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3074
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
00:11.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
00:11.4 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 18)
00:11.5 Multimedia audio controller: VIA Technologies, Inc.: Unknown
device 3059 (rev 10)
01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev
15)

regards

-- 
Marek Pêtlicki <marpet@linuxpl.org>
Linux User ID=162988


