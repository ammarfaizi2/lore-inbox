Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271982AbRH2Oi7>; Wed, 29 Aug 2001 10:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271986AbRH2Oit>; Wed, 29 Aug 2001 10:38:49 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20240 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271985AbRH2Oip>; Wed, 29 Aug 2001 10:38:45 -0400
Date: Wed, 29 Aug 2001 11:38:34 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <Pine.LNX.4.33.0108290648420.8173-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108291137330.30199-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2001, Linus Torvalds wrote:

> Rik, look again: kswapd _does_ wait on IO these days.

Indeed, I missed the magic in sync_page_buffers().

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

