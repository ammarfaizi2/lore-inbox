Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSCTQKE>; Wed, 20 Mar 2002 11:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311737AbSCTQJy>; Wed, 20 Mar 2002 11:09:54 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:64750 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S311735AbSCTQJn>; Wed, 20 Mar 2002 11:09:43 -0500
Date: Wed, 20 Mar 2002 17:09:32 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: aa-160-lru_release_check
In-Reply-To: <3C980990.1C6B232A@zip.com.au>
Message-ID: <Pine.NEB.4.44.0203201703450.3932-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2002, Andrew Morton wrote:

>...
> +		if (unlikely(in_interrupt()))
> +			BUG();
>...

Is there a reason against intruducing BUG_ON in 2.4? It makes such things
more readable.

cu
Adrian


