Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSKXOpD>; Sun, 24 Nov 2002 09:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKXOpC>; Sun, 24 Nov 2002 09:45:02 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:25868 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261450AbSKXOpB>; Sun, 24 Nov 2002 09:45:01 -0500
Date: Sun, 24 Nov 2002 15:51:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Alexander Viro <viro@math.psu.edu>
cc: Werner Almesberger <wa@almesberger.net>, Patrick Mochel <mochel@osdl.org>,
       Rusty Lynch <rusty@linux.co.intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <Pine.GSO.4.21.0211240832460.9014-100000@steklov.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0211241546290.2109-100000@serv>
References: <Pine.GSO.4.21.0211240832460.9014-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 24 Nov 2002, Alexander Viro wrote:

> c) mkdir creating non-empty directory or rmdir removing non-empty directory
> is *ugly*.  BTW, Roman's "filesystem" for modules in its current form is
> vetoed, as far as I'm concerned - this sort of magic is just plain wrong.

I'm open to alternative ideas.
If the contents of the dir again is controlled by the fs itself, I don't 
really see a problem. You need some way to tell the kernel "please create 
this object and give me an interface to control it".

bye, Roman

