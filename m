Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318803AbSG0TF0>; Sat, 27 Jul 2002 15:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318804AbSG0TFZ>; Sat, 27 Jul 2002 15:05:25 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9230 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S318803AbSG0TFZ>; Sat, 27 Jul 2002 15:05:25 -0400
Message-Id: <200207271904.g6RJ4jT27545@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ville Herva <vherva@niksula.hut.fi>, DervishD <raul@pleyades.net>
Subject: Re: About the need of a swap area
Date: Sat, 27 Jul 2002 22:02:51 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <3D42907C.mailFS15JQVA@viadomus.com> <20020727144228.GQ1548@niksula.cs.hut.fi>
In-Reply-To: <20020727144228.GQ1548@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2002 12:42, Ville Herva wrote:
> >     I created a swap area twice as large as my RAM size (just an
> > arbitrary size), that is 1G. I've tested with lower sizes too. My RAM
> > is never filled (well, I haven't seen it filled, at least) since I
> > always work on console, no X and things like those. Even compiling
> > two or three kernels at a time don't consume my RAM. What I try to
> > explain is that the swap is not really needed in my machine, since
> > the memory is not prone to be filled.
>
> So you have 512MB of RAM? All the programs (without X) will fit there
> easily. You'll still have plenty for disk cache.

With today's software I'd say you probably need swap if you have
less than 256M of RAM and use X. You _definitely_ need it if you have less 
than 128M.

X is regularly uses 50+ megs, Mozilla and OpenOffice are big
leaky beasts too. Hopes for improvements are dim.

Really, we have to fight software bloat instead of adding tons of RAM
and swap, but sadly we have quite a number of vital desktop software
packages overbloated.

I am enormously grateful for all kernel developers for Linux kernel
which is:

Memory: 124644k/129536k available
(1403k kernel code, 4436k reserved, 403k data, 152k init, 0k highmem)

Only 1.5 megs of code, 0.5 megs of data!
--
vda
