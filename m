Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSEaOj5>; Fri, 31 May 2002 10:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSEaOj4>; Fri, 31 May 2002 10:39:56 -0400
Received: from 213-145-181-73.dd.nextgentel.com ([213.145.181.73]:13692 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S315338AbSEaOj4>;
	Fri, 31 May 2002 10:39:56 -0400
Subject: Re: [2.4.19-pre9] DMA not available
From: Kjartan Maraas <kmaraas@online.no>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0205301702310.139-100000@bzzzt.slackware.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 31 May 2002 16:38:52 +0200
Message-Id: <1022855932.11533.41.camel@sevilla.gnome.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-05-30 kl. 17:24 skrev Pawel Kot:
> Hi,
> 
> I can't enable DMA with 2.4.19-pre9 with my Dell laptop:
> root@bzzzt:~# hdparm -d 1 /dev/hda
> 
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)

This looks like the same problems I had a while back with my Compaq Evo
N600. It was fixed for me by using the patches from
http://linuxdiskcert.org/

Cheers
Kjartan

