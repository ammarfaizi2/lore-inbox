Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRLHP4s>; Sat, 8 Dec 2001 10:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282083AbRLHP4i>; Sat, 8 Dec 2001 10:56:38 -0500
Received: from yuha.menta.net ([212.78.128.42]:62457 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S282080AbRLHP42>;
	Sat, 8 Dec 2001 10:56:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: "Pantelis Proios" <pproios@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Memory Interleave + kernel + VIA chipsets == possible ?
Date: Sat, 8 Dec 2001 16:55:57 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <F760JPzw2O8Z9B5un770001e64e@hotmail.com>
In-Reply-To: <F760JPzw2O8Z9B5un770001e64e@hotmail.com>
MIME-Version: 1.0
Message-Id: <01120816555700.01330@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Dissabte 08 Desembre 2001 16:02, Pantelis Proios va escriure:
> Is there a way to enable the memory interleaving of modern VIA chipsets
> (Apollo Pro-133 in my case) through the Linux kernel or some other
> software?
>
> From what I understand it's done through some PCI register tweaking ..
> Can it be done with setpci or code is needed ?
>
> any info would be welcomed

i have an ApolloPro 133 and i made that in windoze with a program from somone 
called H. Oda. it was very well documented and i found tweaks for 4x 
interleaving, active paging control, and read around write for the ApolloPro

i wrote the tweaks in a sheet and modified /proc/bus/pci/00/00.0 with a hex 
editor ..... so there is something called setpci to make it easier? will read 
the man page later :)

the fact is that i dont remember the exact bits to tweak, i'm going to load 
windoze and look which bits i had to tweak again, so will mail them to you 
later.

i noticed an interesting increase in memory throughput (with a windoze bench) 
can anyone point a way to test mem throughput in linux so we can test if the 
tweaks work?
