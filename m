Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRATU4e>; Sat, 20 Jan 2001 15:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRATU4Y>; Sat, 20 Jan 2001 15:56:24 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:18439 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129842AbRATU4N>; Sat, 20 Jan 2001 15:56:13 -0500
Date: Sat, 20 Jan 2001 20:56:08 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: Via apollo KX133 ide bug in 2.4.x
Message-ID: <20010120205608.C2838@colonel-panic.com>
Mail-Followup-To: pdh, linux-kernel@vger.kernel.org
In-Reply-To: <3A68DCD1.FACB4135@voicenet.com> <20000120083812.A945@colonel-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20000120083812.A945@colonel-panic.com>; from pdh@colonel-panic.com on Thu, Jan 20, 2000 at 08:38:12AM +0000
From: Peter Horton <pdh@colonel-panic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2000 at 08:38:12AM +0000, Peter Horton wrote:
> 
> I think I'm suffering the same thing on my new Asus A7V. Yesterday I got a
> single "error in bitmap, remounting read only" type error, and today I got
> some files in /tmp that returned I/O error when stat()ed. I do have DMA
> enabled, but only UDMA33. I've done several kernel compiles with no
> problems at all so looks like something is on the edge. Think I might go
> back to 2.2.x for a bit and see what happens, or maybe just remove the VIA
> driver :-((.
> 

I apologise for following up my own E-mail, but there is something I'm
missing here (maybe a whole lot of something). Anyone know how come we're
seeing silent corruption ... I thought this UDMA stuff was all checksummed
? If there error is outside the data I assume the driver would notice ?


P.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
