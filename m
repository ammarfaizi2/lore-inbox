Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293532AbSCKWlP>; Mon, 11 Mar 2002 17:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSCKWlG>; Mon, 11 Mar 2002 17:41:06 -0500
Received: from CPE-203-51-27-33.nsw.bigpond.net.au ([203.51.27.33]:41967 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S293532AbSCKWku>; Mon, 11 Mar 2002 17:40:50 -0500
Message-ID: <3C8D3265.146899B1@eyal.emu.id.au>
Date: Tue, 12 Mar 2002 09:40:37 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre3, with the new IDE code. It has been stable enough time in

ld -m elf_i386 -r -o ide-mod.o ide.o ide-features.o ide-taskfile.o 
aec62xx.o alim15x3.o amd74xx.o cmd640.o cmd64x.o cs5530.o cy82c693.o
hpt34x.o hpt366.o ide-adma.o ide-dma.o ide-pci.o ns87415.o opti621.o
serverworks.o pdc202xx.o pdcadma.o piix.o rz1000.o sis5513.o slc90e66.o
trm290.o via82cxxx.o ide-proc.o
ld: cannot open pdcadma.o: No such file or directory
make[3]: *** [ide-mod.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/ide'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
