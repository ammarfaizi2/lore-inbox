Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275119AbRJAPJ6>; Mon, 1 Oct 2001 11:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275146AbRJAPJs>; Mon, 1 Oct 2001 11:09:48 -0400
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:45828 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S275119AbRJAPJe>; Mon, 1 Oct 2001 11:09:34 -0400
Date: Mon, 1 Oct 2001 11:10:01 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
To: Steven Timm <timm@fnal.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA problem (?) w/2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <Pine.LNX.4.31.0110011000160.4216-100000@snowball.fnal.gov>
Message-ID: <Pine.LNX.4.10.10110011107350.13303-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We began with a system with a Seagate system drive (master, ide0), same
> model as in Marvin's post..   IDE cd rom
> as slave on the ide0 bus, and two IBM data drives on the ide1 bus.
...
> whenever it does happen.  It is wrong to think this problem happens
> only with Seagate drives.

indeed, it seems that the most common trigger for this problem
is simply putting two devices from different vendors on the same channel.
Seagate drives are fairly notorious for not getting along with others.

it's best to think of IDE as a point-to-point link.

regards, mark hahn.

