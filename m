Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSERPKi>; Sat, 18 May 2002 11:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313174AbSERPKh>; Sat, 18 May 2002 11:10:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:22756 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313202AbSERPKg>; Sat, 18 May 2002 11:10:36 -0400
Date: Sat, 18 May 2002 17:10:27 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Anton Altaparmakov <aia21@cantab.net>
cc: mikeH <mikeH@notnowlewis.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: linux 2.5.16 and VIA Chipset
In-Reply-To: <5.1.0.14.2.20020518144515.040cd480@pop.cus.cam.ac.uk>
Message-ID: <Pine.NEB.4.44.0205181706400.21287-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2002, Anton Altaparmakov wrote:

> At 13:47 18/05/02, mikeH wrote:
> >Apologies, on closer examination of the 2.4 and 2.5 dmesg, it hangs just
> >before the
> >ACPI is going to come up. However, there is no option for it in make
> >menuconfig, and enabling it in .config breaks the compile.
>
> What do you mean there is no config option in menuconfig?!? I just checked
> and there is "General options" ---> "ACPI Support" ---> "[ ] ACPI Support".

There are two options that are required and it might be that one of them
is missing:

1. "Code maturity level options" -> "Prompt for development and/or
                                     incomplete code/drivers"
2. "General setup" -> "Power Management support"

Most likely the first one is the missing option (don't expect that the
average user has activated CONFIG_EXPERIMENTAL).

> Best regards,
>
>          Anton

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

