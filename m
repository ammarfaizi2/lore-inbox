Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSGNOcR>; Sun, 14 Jul 2002 10:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316857AbSGNOcQ>; Sun, 14 Jul 2002 10:32:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:61164 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316856AbSGNOcP> convert rfc822-to-8bit; Sun, 14 Jul 2002 10:32:15 -0400
Date: Sun, 14 Jul 2002 16:35:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141324.g6EDOvUe019079@burner.fokus.gmd.de>
Message-ID: <Pine.NEB.4.44.0207141629440.4981-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:

>...
> If a CD-ROM does not support ATAPI, you are not able to
>
> -	open/close/lock the door.
>...

Look at drivers/cdrom/mcdx.c, a driver for proprietary (the device is
connected via an ISA card to the computer) single and double speed Mitsumi
CD-ROM drives. This driver supports to open the door although the drive
definitely doesn't support ATAPI...

> Jörg

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

