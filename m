Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSEFO7A>; Mon, 6 May 2002 10:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314463AbSEFO7A>; Mon, 6 May 2002 10:59:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14099 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314459AbSEFO67>; Mon, 6 May 2002 10:58:59 -0400
Subject: Re: Review: Servercrash with kernel SuSE 2.4.16
To: Oliver.Schersand@BASF-IT-Services.com
Date: Mon, 6 May 2002 16:17:34 +0100 (BST)
Cc: chris.mason@suse.com, alessandro.suardi@oracle.com, sbrand@mainz.ibm.com,
        reiser@namesys.com, linux-kernel@vger.kernel.org
In-Reply-To: <OF10FE0462.9B5B7937-ONC1256BB1.002ADC0F@bcs.de> from "Oliver.Schersand@BASF-IT-Services.com" at May 06, 2002 10:57:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E174kF4-0005RU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This shows us a main problem of Linux in datacenter environment. The
> automatic guarding of the local attached storage and the hardware is very
> importend in this environments. In this environment we use expensive high
> performance hardware. These hardware is not  good  supported by the
> standard linux kernel. The companies which sell these hardware deliver not
> all features of these hardware to the community of linux.  There drivers
> and guarding agents are not distributed under GPL.

I would suggest you review your vendor and hardware policies. The standard
Linux i2c/smbus addons support extensive power and health monitoring for
most standards based systems.

Anyone who loads a product onto a critical datacentre system where the
vendor says "well it might work, but we don't know even with the vendor
supplied kernel" is not being terribly professional about it.

Maybe your products are in fact also supported by open source code, maybe
your choice of hardware is poor. Would you buy Win2K setups where the
vendor said "well the monitoring might work, we dont know" ?

My system temperatures, power status, disk array temperatures and disk SMART
status are all happily being logged. I have no binary modules on the server.


