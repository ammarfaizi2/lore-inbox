Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273450AbRIULvw>; Fri, 21 Sep 2001 07:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273462AbRIULvm>; Fri, 21 Sep 2001 07:51:42 -0400
Received: from edu.joroinen.fi ([195.156.135.125]:9737 "HELO edu.joroinen.fi")
	by vger.kernel.org with SMTP id <S273455AbRIULvd> convert rfc822-to-8bit;
	Fri, 21 Sep 2001 07:51:33 -0400
Date: Fri, 21 Sep 2001 14:51:50 +0300 (EEST)
From: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
X-X-Sender: <pk@edu.joroinen.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Module-loading problem with 4MB of ram
In-Reply-To: <E15jKYe-0000sT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0109211451190.4235-100000@edu.joroinen.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, Alan Cox wrote:

> > ptr =3D dmalloc(size, GFP_ATOMIC);
> > is there any way to reserve some memory for the driver-module?
>
> Since its very unlikely the firmware is DMA transfered into the card (check
> that obviously) I suspect using vmalloc/vfree instead of kmalloc/kfree will
> do the trick
>

Thank you. This really worked!


- Pasi Kärkkäinen

                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.

