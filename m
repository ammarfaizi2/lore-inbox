Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267330AbSLRSVo>; Wed, 18 Dec 2002 13:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267331AbSLRSVo>; Wed, 18 Dec 2002 13:21:44 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:11936 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S267330AbSLRSVm>; Wed, 18 Dec 2002 13:21:42 -0500
Date: Wed, 18 Dec 2002 13:31:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andries Brouwer <aebr@win.tue.nl>
Cc: jiri.wichern@hccnet.nl, "" <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: kernel 2.4.20 option CONFIG_BLK_STATS breaks /proc/partitons
 so "mount" can't mount devices by UUID.
In-Reply-To: <20021217005539.GA11900@win.tue.nl>
Message-ID: <Pine.LNX.4.50L.0212181330100.3431-100000@freak.distro.conectiva>
References: <3DFE6ED2.7174.1395ABF@localhost> <20021217005539.GA11900@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Andries Brouwer wrote:

> On Tue, Dec 17, 2002 at 12:24:50AM +0100, jiri.wichern@hccnet.nl wrote:
>
> > Short description of the problem: You can't mount hard drive
> > volumes by using their UUID number when also using extra
> > statistics for your block devices by the CONFIG_BLK_STATS
> > kernel option.
>
> Yes, we know.
> You use an old version of mount, and the mount will always fail.
>
> Two solutions:
> (i) Do not use CONFIG_BLK_STATS.
> (ii) Upgrade mount to a recent version (mount is part of util-linux,
> recent is for example 2.11y).
>
> Note that solution (ii) gives you a situation where mount and fdisk
> fail sporadically instead of always, maybe not precisely what one
> had hoped. Thus, (i) is the preferred solution.
>
> It was really bad that CONFIG_BLK_STATS went into 2.4.20,
> but you need not use it.

Hi Andries,

Could you please expand on the "sporadically" so we can inform the user in
a better way when he should not use CONFIG_BLK_STATS ?

Mentioning that a newer util-linux is one good thing to be done.
