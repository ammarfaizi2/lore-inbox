Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317081AbSGSVXU>; Fri, 19 Jul 2002 17:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSGSVXU>; Fri, 19 Jul 2002 17:23:20 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:42287 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S317063AbSGSVXT>; Fri, 19 Jul 2002 17:23:19 -0400
Message-ID: <3D3883F6.7090608@fabbione.net>
Date: Fri, 19 Jul 2002 23:26:14 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: =?ISO-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.4.18 and 2.4.19 problems
References: <20020719192607.GA13880@stud.ntnu.no> <20020719140416.A25577@eng2.beaverton.ibm.com>
X-Enigmail-Version: 0.63.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield wrote:

>On Fri, Jul 19, 2002 at 09:26:07PM +0200, Thomas Langås wrote:
>  
>
>>qla2x00_set_info starts at address = f8836060
>>qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
>>scsi1: Found a QLA2200  @ bus 2, device 0x4, irq 16, iobase 0xdc00
>>scsi(1): Allocated 4096 SRB(s)
>>PCI: Setting latency timer of device 02:04.0 to 64
>>scsi(1): Configure NVRAM parameters...
>>scsi(1): 64 Bit PCI Addressing Enabled
>>scsi(1): Verifying loaded RISC code...
>>scsi(1): Verifying chip...
>>scsi(1): Waiting for LIP to complete...
>>scsi(1): Cable is unplugged...
>>qla2x00: Found  VID=1077 DID=2200 SSVID=1077 SSDID=2
>>scsi2: Found a QLA2200  @ bus 2, device 0x5, irq 17, iobase 0xd800
>>scsi(2): Allocated 4096 SRB(s)
>>PCI: Setting latency timer of device 02:05.0 to 64
>>scsi(2): Configure NVRAM parameters...
>>scsi(2): 64 Bit PCI Addressing Enabled
>>scsi(2): Verifying loaded RISC code...
>>scsi(2): Verifying chip...
>>scsi(2): Waiting for LIP to complete...
>>scsi(2): Cable is unplugged...
>>
I have an HSG80 connected on the other side and I got this problem with
the beta6 drivers from qlogic.

The only way I made it working was using the kernel driver shipped with 
rh7.3
that has been modified to support the HSG80 (according to the changelog  
supported
only by the beta6 series).

Fabio

