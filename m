Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbTBBOkv>; Sun, 2 Feb 2003 09:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTBBOkv>; Sun, 2 Feb 2003 09:40:51 -0500
Received: from smtp04.iprimus.com.au ([210.50.76.52]:55820 "EHLO
	smtp04.iprimus.com.au") by vger.kernel.org with ESMTP
	id <S265306AbTBBOku>; Sun, 2 Feb 2003 09:40:50 -0500
Message-Id: <5.1.0.14.0.20030203014900.00a087c0@pop.iprimus.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 03 Feb 2003 01:49:42 +1100
To: Mark Hahn <hahn@physics.mcmaster.ca>
From: James Buchanan <jamesbuch@iprimus.com.au>
Subject: Re: Anyone supporting Intel 8XX chipset???
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0302020939560.6653-100000@coffee.psychology.
 mcmaster.ca>
References: <5.1.0.14.0.20030203000618.00a0eb20@pop.iprimus.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-OriginalArrivalTime: 02 Feb 2003 14:50:15.0884 (UTC) FILETIME=[65BC50C0:01C2CACA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, forget it.


At 09:43 AM 2/2/2003 -0500, Mark Hahn wrote:
> > Is anyone writing code to directly support features of the Intel 800 series
> > chipsets?  I'm using the 8xx chipset docs from Intel to gradually
> > implement (hopefully) all the features of the 800 series of chipsets.
>
>such a broad statement is difficult.  are you sure that most of the
>features aren't already implemented?
>
> > The support of the I/O hubs and so on to get rid of relying on legacy
> > PC/AT stuff will take a while.
>
>huh?  IO hubs are for the most part transparent.  what legacy do you
>want to get rid of?  just trivia like ide supporting its traditional
>(standard) IO aperture?
>
> > I have a couple of questions because I'm new to kernel contributions.
> > I'll be working in two main files, i8xx.h and i8xx.c, possibly i8xx.s too.
> > In the early stages I may have a directory /i8xx and implementation of
> > specific features will go into there in separate files.
>
>except that the chipset is not either a coherent set of devices
>or noticably different from previous hardware.
>
> > One thing: should I maintain the consistency of using /dev files?  Because
> > there
> > is a hardware random number generator in the 800 series chipsets, and I
>
>but the RNG has had kernel support for years.
>
> > am wondering whether I should export this feature as a set of functions or
> > a /dev file.  (Both??)
>
>afaik, no one cares whether a special-purpose and minor driver like that
>would export a traditional static major/minor interface,
>or a simple /proc one.

