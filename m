Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262871AbSJGFfc>; Mon, 7 Oct 2002 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJGFfc>; Mon, 7 Oct 2002 01:35:32 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:32135 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262871AbSJGFfa>; Mon, 7 Oct 2002 01:35:30 -0400
Date: Mon, 7 Oct 2002 02:40:52 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: Linux Kernel Development List <linux-kernel@vger.kernel.org>
Subject: Re: Idea: (Category: Memory Management) Increase the Number of Lists
 of Blocks that Contain Groups of Contiguous Page Frames
In-Reply-To: <000901c26dba$7d4f7860$5f71d73f@joe>
Message-ID: <Pine.LNX.4.44L.0210070239370.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Oct 2002, Joseph D. Wagner wrote:

> NOTE: This seems way too easy, IMHO.  I'm not an experienced kernel
> developer so someone please check me on this.

If it looks way to easy, it usually is.

Your idea won't help squat for userland programs like X,
because those programs still allocate stuff one page at
a time.

Besides, why would it matter whether these programs get
physically contiguous memory or not ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

