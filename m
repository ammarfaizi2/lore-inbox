Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbQKFXuT>; Mon, 6 Nov 2000 18:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129928AbQKFXuJ>; Mon, 6 Nov 2000 18:50:09 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:57147 "EHLO
	amsmta05-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129729AbQKFXuB>; Mon, 6 Nov 2000 18:50:01 -0500
Date: Tue, 7 Nov 2000 01:57:34 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: Paul Powell <moloch16@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: xterm: no available ptys
In-Reply-To: <20001106203738.17935.qmail@web110.yahoomail.com>
Message-ID: <Pine.LNX.4.21.0011070157010.30406-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Paul Powell wrote:

> Hello,
> 
> I have created a trimmed down /dev directory to be
> used with my custom bootable Linux CD.  I've run into
> a problem where I can't start an xterm.  I get the
> error...
> 
> xterm:  no available ptys
> 
> I'm not sure which device I'm missing in /dev.  I'm no
> expert on how the tty's and stuff work so feel free to
> fill me in. Everything else seems to work fine on the
> CD.
> 
> Here is what my /dev directory looks like now:
> 
> /dev:
> console
> cua0
> cua1
> cua2
> cua3
> fb
> fb0
> fb1
> fb2
> fb3
> fb4
> fb5
> fb6
> fb7
> fd0
> fd1
> hda
> hdb
> hdc
> hdd
> kmem
> listing
> mem
> mouse
> null
> psaux
> pts
>  |...0

I'm missing ptmx. You NEED a writable /dev/pts dir.



	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
