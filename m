Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266125AbRGPFJC>; Mon, 16 Jul 2001 01:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266129AbRGPFIw>; Mon, 16 Jul 2001 01:08:52 -0400
Received: from 64.5.206.104 ([64.5.206.104]:50190 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S266125AbRGPFIf>; Mon, 16 Jul 2001 01:08:35 -0400
Date: Mon, 16 Jul 2001 01:08:35 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: Alex Buell <alex.buell@tahallah.demon.co.uk>
cc: Mailing List - Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Duplicate '..' in /lib 
In-Reply-To: <Pine.LNX.4.33.0107160548400.3655-100000@tahallah.demon.co.uk>
Message-ID: <Pine.LNX.4.33.0107160106280.17437-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Alex Buell wrote:

> I just found a pair of '..' directories in the /lib directory. e2fsck 1.19
> didn't even pick up on this!
>
> /lib
>    4 drwxr-xr-x   19 root     root         4096 Jun  9 16:06 ..
>    4 -rw-rw-r--    1 root     root           27 Jun  9 15:55 ..
>
> How can I get rid of this? I'm on kernel 2.2.19, running on sparc-linux.

This is the wrong place to ask this kind of question; you're better of trying
an appropriate newsgroup.

Obviously one of the entries is the real '..', the other is not. If you use
'ls -b' it should show you any non-visible characters (maybe a space, i.e.,
'..\ ').

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

