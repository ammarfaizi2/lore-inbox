Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLDCir>; Mon, 3 Dec 2001 21:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283129AbRLCXvh>; Mon, 3 Dec 2001 18:51:37 -0500
Received: from [213.21.143.134] ([213.21.143.134]:18445 "EHLO
	master.oasi.gpa.it") by vger.kernel.org with ESMTP
	id <S284494AbRLCMHi>; Mon, 3 Dec 2001 07:07:38 -0500
Date: Mon, 3 Dec 2001 13:04:26 +0100 (CET)
From: Riccardo Facchetti <riccardo@master.oasi.gpa.it>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Riccardo Facchetti <fizban@tin.it>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] s|sound/lowlevel/aedsp16.c|sound/aedsp16.c|
In-Reply-To: <Pine.NEB.4.43.0112031122010.11219-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.33.0112031302220.6853-100000@master.oasi.gpa.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marcelo, I have some more minor changes to apply (email change etc)
I will submit a patch asap.

Ciao,
	Riccardo.

On Mon, 3 Dec 2001, Adrian Bunk wrote:

> Hi Riccardo,
>
> the patch below (against 2.4.17-pre2) corrects three files that referred
> to the old location of aedsp16.c
>
>
> --- drivers/sound/aedsp16.c.old	Mon Dec  3 11:22:05 2001
> +++ drivers/sound/aedsp16.c	Mon Dec  3 11:22:20 2001
> @@ -1,5 +1,5 @@
>  /*
> -   drivers/sound/lowlevel/aedsp16.c
> +   drivers/sound/aedsp16.c
>
>     Audio Excel DSP 16 software configuration routines
>     Copyright (C) 1995,1996,1997,1998  Riccardo Facchetti (fizban@tin.it)
> --- Documentation/sound/AudioExcelDSP16.old	Mon Dec  3 11:19:41 2001
> +++ Documentation/sound/AudioExcelDSP16	Mon Dec  3 11:19:56 2001
> @@ -2,7 +2,7 @@
>  ------
>
>  Informations about Audio Excel DSP 16 driver can be found in the source
> -file lowlevel/aedsp16.c
> +file aedsp16.c
>  Please, read the head of the source before using it. It contain useful
>  informations.
>
> --- Documentation/Configure.help.old	Mon Dec  3 11:10:53 2001
> +++ Documentation/Configure.help	Mon Dec  3 11:18:01 2001
> @@ -18367,7 +18367,7 @@
>    questions.
>
>    Read the <file:Documentation/sound/README.OSS> file and the head of
> -  <file:drivers/sound/lowlevel/aedsp16.c> as well as
> +  <file:drivers/sound/aedsp16.c> as well as
>    <file:Documentation/sound/AudioExcelDSP16> to get more information
>    about this driver and its configuration.
>
>
> cu
> Adrian
>
> --
>
> Get my GPG key: finger bunk@debian.org | gpg --import
>
> Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400
>

