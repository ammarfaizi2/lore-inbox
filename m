Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJCUaj>; Thu, 3 Oct 2002 16:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbSJCUai>; Thu, 3 Oct 2002 16:30:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2755 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261293AbSJCUai>; Thu, 3 Oct 2002 16:30:38 -0400
Date: Thu, 3 Oct 2002 22:36:03 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Sergio Costas <raster@rastersoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel 2.4.19?
In-Reply-To: <1031768280.998.5.camel@localhost.localdomain>
Message-ID: <Pine.NEB.4.44.0210032234261.14433-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Sep 2002, Sergio Costas wrote:

> Hello:

Hi Sergio,

> I think I found a bug in kernel 2.4.19. I enclose all the information
> you say in www.kernel.org
>
> Bug in memory management in kernel 2.4.19
>
> This kernel seems to have a problem when a huge amount of memory is
> allocated by a program. In my case, I work with GIMP, with a picture of
> 5000 x 3500 pixels. When I try to move a 'big' selection (25% or more of
> the surface of the picture), my linux system simply reboots. No kernel
> panic, no hangs, no popups... simply reboots after accessing a lot to
> the hard disk (for memory swapping, of course). There's no problem with
> kernel 2.4.18 (I changed to it after discover this), so it seems to be a
> new bug.
>...

are there any messages in /var/log/syslog or in /var/log/messages that
might be related? Anything else that might give a hint where the problem
comes from?

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

