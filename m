Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265537AbSKYTdU>; Mon, 25 Nov 2002 14:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265564AbSKYTdU>; Mon, 25 Nov 2002 14:33:20 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:47626 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265537AbSKYTdU>; Mon, 25 Nov 2002 14:33:20 -0500
Date: Mon, 25 Nov 2002 20:40:12 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Patrick Mochel <mochel@osdl.org>
cc: Werner Almesberger <wa@almesberger.net>,
       Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
In-Reply-To: <Pine.LNX.4.33.0211251136590.898-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0211252035550.2109-100000@serv>
References: <Pine.LNX.4.33.0211251136590.898-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Nov 2002, Patrick Mochel wrote:

> [ From a purist standpoint, it's still a little weird. Al has been telling
> me for ages that the only proper way to do it is to have each object get a
> mountpoint instead of a directory. According to him, which I generally
> take as gospel, it's the only way to do in-kernel filesystems in a
> race-free way. It's hard, and IIRC, there are several infrastructural
> changes that must take place in order for it to happen. (I think I still
> have the IRC log somewhere..) But, it might happen someday.. ]

What advantages do mountpoints have compared to normal directories?

bye, Roman

