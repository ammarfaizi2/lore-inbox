Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267242AbSLEGlV>; Thu, 5 Dec 2002 01:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267244AbSLEGlV>; Thu, 5 Dec 2002 01:41:21 -0500
Received: from 24.213.60.123.up.mi.chartermi.net ([24.213.60.123]:26308 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id <S267242AbSLEGlU>; Thu, 5 Dec 2002 01:41:20 -0500
Date: Thu, 5 Dec 2002 01:48:51 -0500 (EST)
From: Nathaniel Russell <root@chartermi.net>
X-X-Sender: root@reddog.example.net
To: Dave Jones <davej@codemonkey.org.uk>
cc: reddog83@chartermi.net, <linux-kernel@vger.kernel.org>
Subject: Re: Help with Via AGP Card
In-Reply-To: <20021204130622.GF647@suse.de>
Message-ID: <Pine.LNX.4.44.0212050148010.945-100000@reddog.example.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have a patch i can try out or what do i type into the agpgart_be.c
file to make my AGP card work???
PLZ Help me.
Nathaniel

On Wed, 4 Dec 2002, Dave Jones wrote:

> On Tue, Dec 03, 2002 at 09:57:56PM -0500, Nathaniel Russell wrote:
>  > I have a Via Agp card that reports that it cant be found it i just type in
>  > /sbin/modprobe agpgart or /sbin/insmod agpgart
>  > but if i do a /sbin/modprobe agpgart agp_try_unsupport=1 or /sbin/insmod
>  > agpgart agp_try_unsupported=1 it shows up and works.
>  > Some help here plz i would like to just have to type in /sbin/modprobe
>  > agpgart but if i cant that would be ok them me.
>
> Simple addition to the "recognised GARTs" table in
> drivers/char/agpgart_be.c should do the trick.
>
> 		Dave
>
> --
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
>

