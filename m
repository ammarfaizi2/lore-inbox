Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262265AbSJNXyu>; Mon, 14 Oct 2002 19:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262267AbSJNXyu>; Mon, 14 Oct 2002 19:54:50 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:3970 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262265AbSJNXys>; Mon, 14 Oct 2002 19:54:48 -0400
Date: Mon, 14 Oct 2002 22:00:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Chris Wedgwood <cw@f00f.org>
cc: Daniele Lugli <genlogic@inrete.it>, <linux-kernel@vger.kernel.org>
Subject: Re: unhappy with current.h
In-Reply-To: <20021014202404.GA10777@tapu.f00f.org>
Message-ID: <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Chris Wedgwood wrote:
> On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:
>
> > I recently wrote a kernel module which gave me some mysterious
> > problems. After too many days spent in blood, sweat and tears, I found the cause:
>
> > *** one of my data structures has a field named 'current'. ***
>
> gcc -Wshadow

Would it be a good idea to add -Wshadow to the kernel
compile options by default ?

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

