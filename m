Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUDPGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 02:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUDPGB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 02:01:56 -0400
Received: from lpbproductions.com ([68.98.208.147]:61154 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S262424AbUDPGBw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 02:01:52 -0400
From: "Matt H." <lkml@lpbproductions.com>
Reply-To: lkml@lpbproduction.scom
To: linux-kernel@vger.kernel.org
Subject: Re: Promise SX-6000 and kernel 2.6.5
Date: Thu, 15 Apr 2004 23:00:58 -0700
User-Agent: KMail/1.6.51
References: <1082093803.4962.86.camel@bene.samgtp>
In-Reply-To: <1082093803.4962.86.camel@bene.samgtp>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404152302.38441.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can also confirm that this card doesn't work in 2.6 when using the generic 
i2o drivers.

Matt H.

On Thursday 15 April 2004 10:36 pm, you wrote:
> Hello!!!
>
>  I am sorry for the letter, but allow to address to you with my problem.
> Has bought Promise SX-6000 Pro the controller and has established on him
> Linux Redhat. All - is excellent!! Has updated a nucleus for 2.6.5 - I
> can not pick up the controller in any way. Source codes of a nucleus
> taking place on your site do not approach for 2.6 nucleus :(
>
> Can you know the possible decision of my problem??
>
>  Yours faithfully and hope, Alexey.
>
> P.S.1 firmware drivers for 2.4.x kernel download is
> http://www.eventus.de/linux.html
>
> P.S.2
>
> In make menuconfig has disconnected support of all PDC Promise. Has
> included all I2O devices in a nucleus.
>
> ns linux # cat .config|grep I2O
> # I2O device support
> CONFIG_I2O=y
> CONFIG_I2O_PCI=y
> CONFIG_I2O_BLOCK=y
> CONFIG_I2O_SCSI=y
> CONFIG_I2O_PROC=y
>
>
> dmesg send 0 i2o controllers
>
> I2O Core - (C) Copyright 1999 Red Hat Software
> I2O: Event thread created as pid 17
> i2o: Checking for PCI I2O controllers...
> I2O configuration manager v 0.04.
>   (C) Copyright 1999 Red Hat Software
> I2O Block Storage OSM v0.9
>    (c) Copyright 1999-2001 Red Hat Software.
> i2o_block: Checking for Boot device...
> i2o_block: Checking for I2O Block devices...
> i2o_scsi.c: Version 0.1.2
>   chain_pool: 0 bytes @ f7ae85a0
>   (512 byte buffers X 4 can_queue X 0 i2o controllers)
>
>
> lspci:
>
> 02:02.1 Class ff00: Intel Corp. 80960RM [i960RM Microprocessor] (rev 02)
> (prog-if 01)
>         Subsystem: Promise Technology, Inc. SuperTrak SX6000 I2O CPU
>         Flags: bus master, medium devsel, latency 32, IRQ 22
>         Memory at f6000000 (32-bit, prefetchable) [size=4M]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
