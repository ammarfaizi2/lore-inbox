Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263088AbSJGPQZ>; Mon, 7 Oct 2002 11:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263092AbSJGPQZ>; Mon, 7 Oct 2002 11:16:25 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:27792 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263088AbSJGPQW>; Mon, 7 Oct 2002 11:16:22 -0400
Date: Mon, 7 Oct 2002 12:21:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Philipp Steinkrueger <kernel@cyberraum.de>
cc: linux-kernel@vger.kernel.org, <linux-admin@vger.kernel.org>
Subject: Re: Memory Problem
In-Reply-To: <021701c26e0e$7d4449a0$0a01a8c0@3rgu5vk6e645pg>
Message-ID: <Pine.LNX.4.44L.0210071218390.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Philipp Steinkrueger wrote:

> The Problem appears with the mysql database server. here is the error
> message:
>
> Can't create a new thread (errno 11). If you are not out of available
> memory, you can consult the manual for a possible OS-dependent bug

> 2) what else does the kernel do when a programm spawns a new thread ? if
> memory is not the problem, what else could go wrong when creating a
> thread ?

There are two limits you could be running into:

1) you run into the per-user thread limit or the system-wide
   thread limit

2) memory fragmentation, there is no area of 2 contiguous free pages

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

