Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280624AbRKNPBa>; Wed, 14 Nov 2001 10:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280623AbRKNPBU>; Wed, 14 Nov 2001 10:01:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:60688 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280625AbRKNPBE>; Wed, 14 Nov 2001 10:01:04 -0500
Date: Wed, 14 Nov 2001 13:00:44 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Sebastian =?iso-8859-1?q?Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
In-Reply-To: <20011114124337Z280554-17408+14330@vger.kernel.org>
Message-ID: <Pine.LNX.4.33L.0111141258500.20809-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001, Sebastian Dröge wrote:

> After two or three days the used swap-space is around 3 MB. I just
> played MP3s and no X and no other "big" applications were running.
> This isn't really a problem but it doesn't look good. Just because of
> cache swap gets full :(

"This isn't really a problem" is a good analysis of the
situation, since 2.4.14/15 often have data duplicated
in both swap and RAM, so being 3MB into swap doesn't mean
3MB of your programs isn't in RAM.

If you take a look at /proc/meminfo, you'll find a field
called "SwapCached:", which tells you exactly how much
of your memory is duplicated in both swap and RAM.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

