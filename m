Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318247AbSGWXUG>; Tue, 23 Jul 2002 19:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSGWXUG>; Tue, 23 Jul 2002 19:20:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3332 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318247AbSGWXUF>; Tue, 23 Jul 2002 19:20:05 -0400
Date: Tue, 23 Jul 2002 19:29:49 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Daniel Tschan <tschan+linux-kernel@devzone.ch>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19-rc3 incorrectly detects PDC20276 in ATA mode as raid
 controller 
In-Reply-To: <32868.80.218.9.155.1027457806.squirrel@www.devzone.ch>
Message-ID: <Pine.LNX.4.44.0207231928180.30493-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Set CONFIG_PDC202XX_FORCE on.

On Tue, 23 Jul 2002, Daniel Tschan wrote:

> Hi
>
> Kernel 2.4.19-rc3 introduces a new bug regarding the Promise PDC20276
> controller. One of my machines has a Gigabyte GA-8IRXP Motherboard with an
> onboard Promise PDC20276. The controller can either be run in RAID or in
> ATA mode. I operate it in ATA mode. Kernel 2.4.19-rc3 now incorrectly
> skips IDE initialization of the PDC20276 because it thinks it's a RAID
> controller which results in a kernel panic (the root filesystem is on a
> harddisk connected to the Promise controller). It outputs a message like
> this before it panics: PDC20276: Skipping RAID controller. This worked
> correctly in 2.4.19-rc2.
>
> Regards
> Daniel
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

