Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267129AbTBHXul>; Sat, 8 Feb 2003 18:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbTBHXul>; Sat, 8 Feb 2003 18:50:41 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:29391 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267129AbTBHXuj>; Sat, 8 Feb 2003 18:50:39 -0500
Date: Sat, 8 Feb 2003 22:00:05 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jerome de Vivie <jerome.devivie@free.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: mmap inside kernel memory.
In-Reply-To: <3E45A7C4.8F1EBDFA@free.fr>
Message-ID: <Pine.LNX.4.50L.0302082159460.12742-100000@imladris.surriel.com>
References: <3E45A7C4.8F1EBDFA@free.fr>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Jerome de Vivie wrote:

> "mmap" seems to be design for mapping file or device inside a process
> memory. Is it possible to map a file into the kernel virtual memory ?

In theory yes (using vmalloc space), but you really don't want to.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
