Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314106AbSEITJb>; Thu, 9 May 2002 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314132AbSEITJa>; Thu, 9 May 2002 15:09:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2061 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S314106AbSEITJ3>; Thu, 9 May 2002 15:09:29 -0400
Date: Thu, 9 May 2002 16:08:16 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <Pine.LNX.3.96.1020509095715.7914B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44L.0205091607400.7447-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2002, Bill Davidsen wrote:

> I have been simply counting WaitIO ticks when there is (a) no runable
> process in the system, and (b) at least one process blocked for disk i/o,
> either page or program. And instead of presenting it properly I just
> stuffed it in a variable and read it from kmem.

OK, how did you measure this ?

And should we measure read() waits as well as page faults or
just page faults ?

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

