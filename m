Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbSIZUEE>; Thu, 26 Sep 2002 16:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261480AbSIZUEE>; Thu, 26 Sep 2002 16:04:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52705 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261374AbSIZUD7>; Thu, 26 Sep 2002 16:03:59 -0400
Date: Thu, 26 Sep 2002 17:09:10 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Marco Colombo <marco@esi.it>
Cc: Ernst Herzberg <earny@net4u.de>, Adam Goldstein <Whitewlf@Whitewlf.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <Pine.LNX.4.44.0209262141320.26363-100000@Megathlon.ESI>
Message-ID: <Pine.LNX.4.44L.0209261708190.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Marco Colombo wrote:

> Say we set MaxKeepAliveRequests to 190 (~2/3 of 256) instead of 1000.
>
> How many requests does a client perform before it hits the 15 sec idle
> timer?  Is it 189? The apache process is stuck in the timeout phase
> anyway. Is it 191? Then the first apache process drops the keepalive
> connection, the client reconnects to a second server process, which
> is stuck again in the timeout phase. Or am I missing something?

As I read it, MaxKeepAliveRequests is the maximum of simultaneous
keepalive requests that are tying up apache processes.

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

