Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbRGPQXf>; Mon, 16 Jul 2001 12:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267453AbRGPQX0>; Mon, 16 Jul 2001 12:23:26 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:24075
	"EHLO awak") by vger.kernel.org with ESMTP id <S267452AbRGPQXN>;
	Mon, 16 Jul 2001 12:23:13 -0400
Subject: Re: Linux 2.4.6-ac4
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <995286249.28503.22.camel@nomade>
In-Reply-To: <200107161158.NAA09324@harpo.it.uu.se> 
	<995286249.28503.22.camel@nomade>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 16 Jul 2001 18:18:29 +0200
Message-Id: <995300310.28503.27.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2001 14:24:08 +0200, Xavier Bestel wrote:
> it does not boot here.
> 
> I use 2.4.6-ac4, with the following hand-made patch in
> drivers/pci/quirks.c:
> 
> -		if (rev < 0x40 && rev > 0x42)
> +		if (rev < 0x40 || rev > 0x42)
> 
> It stops right after:
> hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
> 
> I have a VIA686b, lspci and all on demand.

Exactely the same behavior for -ac5 ...

Xav

