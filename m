Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282812AbRLKUEl>; Tue, 11 Dec 2001 15:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLKUEb>; Tue, 11 Dec 2001 15:04:31 -0500
Received: from stud.fbi.fh-darmstadt.de ([141.100.40.65]:31665 "EHLO
	stud.fbi.fh-darmstadt.de") by vger.kernel.org with ESMTP
	id <S282814AbRLKUEX>; Tue, 11 Dec 2001 15:04:23 -0500
Date: Tue, 11 Dec 2001 20:58:46 +0100 (CET)
From: Jan-Marek Glogowski <glogow@stud.fbi.fh-darmstadt.de>
To: Samuel Maftoul <maftoul@esrf.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OT?] SuSe kernel
In-Reply-To: <20011211193048.A22075@pcmaftoul.esrf.fr>
Message-ID: <Pine.LNX.4.30.0112112051310.7727-100000@stud.fbi.fh-darmstadt.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam

> In SuSe's kernel there is a nice feature but I cannot  found where is
> the code that does it and so I cannot play with it 8-).
> The thing I'm talking about is grpahical boot + graphical first console.
> I glanced at include/asm-i386/linux_logo.h but it doesn't differ.
> Can someone help me ?

Install the package "kernel-source" from zq (source) series.
The patch in the archives you have to look for is named ...boot-splash...
The important files in the patched kernel tree are:

linux/drivers/video/fbcon-splash.[ch]

There are some more changes in the whole fbcon* files (for alpha blending
etc.).

HTH

Jan-Marek

