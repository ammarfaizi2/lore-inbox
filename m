Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317042AbSEWW6F>; Thu, 23 May 2002 18:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317043AbSEWW6E>; Thu, 23 May 2002 18:58:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:58530 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317042AbSEWW6D>;
	Thu, 23 May 2002 18:58:03 -0400
Date: Fri, 24 May 2002 00:57:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jorge Nerin <comandante@zaralinux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cannot write a 90' cd
Message-ID: <20020524005754.I27005@ucw.cz>
In-Reply-To: <3CED69EB.2060003@zaralinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 12:15:07AM +0200, Jorge Nerin wrote:
> Hello, I tried with kernels 2.5.16, 2.5.15 and 2.4.18 with a ide cdburner:
> 
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>    Vendor: SAMSUNG   Model: CD-R/RW SW-208B   Rev: BS03
>    Type:   CD-ROM                             ANSI SCSI revision: 02
> 
> with cdrecord --version
> Cdrecord 1.11a19 (i586-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
> but it's a 1.11a21, and a 2x200mmx 96Mb. and the results were rather disapointing:
> 
> - 2.5.15 & 2.5.16 both hung my machine the moment cdrecord tried to write.
> - 2.4.18 wrote ok, until 702MB, then a scsi stopped the procces, detailed log of 
> the cdrecord session follows:
> Note that this was a traxdata 90' silver cd, in the instructions they said that 
> it will be detected as a 80' and that you should enable overburnung, cdrecord 
> without options said that -overburn should be active, this session is with 
> -overburn active.
> 
> I don't have more 90' cd to try. I only managed to get one.

90 minute CD-Rs have a tighter leading track, and only some CD-R drives
are able to cope with that. For example my Ricoh doesn't, failing some
54 minutes after start. There is nothing you can do about that.

-- 
Vojtech Pavlik
SuSE Labs
