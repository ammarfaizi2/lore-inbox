Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSESP5F>; Sun, 19 May 2002 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314505AbSESP5E>; Sun, 19 May 2002 11:57:04 -0400
Received: from dsl-64-129-199-125.telocity.com ([64.129.199.125]:14976 "HELO
	descola.net") by vger.kernel.org with SMTP id <S314491AbSESP5C>;
	Sun, 19 May 2002 11:57:02 -0400
Date: Sun, 19 May 2002 08:57:01 -0700
From: "Darrell A. Escola" <darrell-kernel@descola.net>
To: David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with swap partition.
Message-ID: <20020519155701.GA21217@descola.net>
Reply-To: linux-kernel@vger.kernel.org
Mail-Followup-To: "Darrell A. Escola" <darrell-kernel@descola.net>,
	David Eduardo Gomez Noguera <davidgn@servidor.unam.mx>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1021824299.2430.7.camel@hikaru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 11:04:57AM -0500, David Eduardo Gomez Noguera wrote:
> Hello.
> I have just changed to a new hard disk:
> 
> Disk /dev/hdc: 16 heads, 63 sectors, 77545 cylinders
> 
> Nr AF  Hd Sec  Cyl  Hd Sec  Cyl    Start     Size ID
>  1 00   1   1    0  15  63   65       63    66465 83
>  2 00   0   1   66  15  63 1023    66528 77952672 83
>  3 00  15  63 1023  15  63 1023 78019200   146160 82
>  4 00   0   0    0   0   0    0        0        0 00
> 
> The 3'rd partition is a Linux Swap,
> /dev/hdc3         77401     77545     73080   82  Linux swap
> 
> but swapon -a gives
> swapon: /dev/hdc5: Invalid argument
> 

Is hcd5 in your /etc/fstab? - might need to change that to hdc3

Darrell
