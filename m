Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287892AbSAMBNt>; Sat, 12 Jan 2002 20:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287895AbSAMBNj>; Sat, 12 Jan 2002 20:13:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4868 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287892AbSAMBNf>; Sat, 12 Jan 2002 20:13:35 -0500
Subject: Re: Driver via ac97 sound problem (VT82C686B)
To: p1orenz@yahoo.com (Paul Lorenz)
Date: Sun, 13 Jan 2002 01:25:16 +0000 (GMT)
Cc: salvador@inti.gov.ar, linux-kernel@vger.kernel.org
In-Reply-To: <20020112205916.92247.qmail@web20910.mail.yahoo.com> from "Paul Lorenz" at Jan 12, 2002 12:59:16 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PZOe-0003fZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I appreciate your help. I added the following line
> to drivers/sound/ac97_codec.c
>        
> {0x41445361, "Analog Devices AD1886",   &default_ops},
> 
> I then recompiled. Now when I load the module I get
> the following...

The VIA driver doesnt appear to support the ac97 ops.
