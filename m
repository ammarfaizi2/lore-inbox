Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFBTpO>; Sun, 2 Jun 2002 15:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313419AbSFBTpN>; Sun, 2 Jun 2002 15:45:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:36549 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313416AbSFBTpN>; Sun, 2 Jun 2002 15:45:13 -0400
Date: Sun, 2 Jun 2002 21:45:18 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@neptun.fachschaften.tu-muenchen.de
To: Russell King <rmk@arm.linux.org.uk>
cc: LKML <linux-kernel@vger.kernel.org>, CPUfreq <cpufreq@www.linux.org.uk>
Subject: Re: [PATCH] cpufreq core for 2.5
In-Reply-To: <20020602203510.A11542@flint.arm.linux.org.uk>
Message-ID: <Pine.NEB.4.44.0206022144280.1674-100000@neptun.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,


>...
> --- orig/incldue/linux/cpufreq.h	Sat Apr 26 08:56:46 1997
> +++ linux/include/linux/cpufreq.h	Wed May  1 17:32:20 2002
>...
> +#ifndef CONFIG_SMP
>...
> +#else
>...
> +#error fill in SMP version
> +#endif
>...


this means that it's impossible to compile it into a kernel with
CONFIG_SMP enabled. Are there any plans to fix this?


TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


