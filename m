Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSLJSHW>; Tue, 10 Dec 2002 13:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbSLJSHW>; Tue, 10 Dec 2002 13:07:22 -0500
Received: from spacecake.plus.com ([195.166.148.239]:14976 "EHLO
	unicorn.encapsulated.net") by vger.kernel.org with ESMTP
	id <S263321AbSLJSHW>; Tue, 10 Dec 2002 13:07:22 -0500
Date: Tue, 10 Dec 2002 18:09:31 +0000
From: Spacecake <lkml@spacecake.plus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sflory@rackable.com, linux-kernel@vger.kernel.org
Subject: Re: HPT372 RAID controller
Message-Id: <20021210180931.0b174cd5.lkml@spacecake.plus.com>
In-Reply-To: <1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>
	<3DF4E433.5010207@rackable.com>
	<20021209203338.32e8665f.lkml@spacecake.plus.com>
	<1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Check the notes on -ac kernels when doing this. I try and note when
> stuff is stable or not

Because of a recent crash (the first ever using linux on this hardware,
using 2.4.18 through 2.4.20), i went in search of these release notes. I
feel really stupid here, but i can't find them, not on
linux.org.uk/thefreeworld.net, google, kernel.org... umm?

The crash in question was while copying between hard disks (both on the
RAID controller) a directory tree of MP3s, about 95megs. I was in X at
the time so i couldn't see any errors if there was some, and the machine
totally locked up, tried pinging it etc, didn't work.
Can't find any errors in logfiles or anything.

The .config for the kernel was identical to my 2.4.20 config that has
never crashed, except it has IDE Taskfile IO enabled, because from the
help this seemed like a good thing.

Do you want me to provide debugging info on this? It's okay if not, i'll
just wait until stuff works in the main stable kernel :)

Thanks,
 - Daniel

P.S. please CC any replies to me, i'm no longer subscribed to LKML.
