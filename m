Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSEBVVw>; Thu, 2 May 2002 17:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSEBVVv>; Thu, 2 May 2002 17:21:51 -0400
Received: from 213-145-191-71.dd.nextgentel.com ([213.145.191.71]:18473 "EHLO
	sevilla.gnome.no") by vger.kernel.org with ESMTP id <S315429AbSEBVVu>;
	Thu, 2 May 2002 17:21:50 -0400
Subject: Re: 2.4.19pres and IDE DMA
From: Kjartan Maraas <kmaraas@online.no>
To: Samuel Flory <sflory@rackable.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3CD1A469.9040605@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 02 May 2002 23:21:20 +0200
Message-Id: <1020374480.3134.1.camel@sevilla.gnome.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tor, 2002-05-02 kl. 22:41 skrev Samuel Flory:
>   I'm having issues with a Tyan 2720 and post 2.4.18 boards with a 
> Maxtor 4G120J6.  Under 2.4.18 I can turn on dma via "hdparm -d 1". 
>  Under 2.4.19pre7 I get "HDIO_SET_DMA fail ed: Operation not permitted". 
>  On a side note the same thing occurs with the RH 2.4.18-0.13 kernel. 
>  It appears both kernels merged an ide update from the ac kernel line.
> 
> PS-There is also some issue with a resource conflict that occurs under 
> every kernel I've tried.

I had the exact same problem myself with a brand new Compaq N600c
laptop. It was fixed for me by using Andre's patch from
http://linuxdiskcert.org/

Cheers
Kjartan

