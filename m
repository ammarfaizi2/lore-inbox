Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280837AbRKBVMw>; Fri, 2 Nov 2001 16:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280841AbRKBVMm>; Fri, 2 Nov 2001 16:12:42 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:60681 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S280837AbRKBVM0>;
	Fri, 2 Nov 2001 16:12:26 -0500
Date: Fri, 2 Nov 2001 19:12:09 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <9ruvkd$jh1$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0111021911210.2963-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Linus Torvalds wrote:

> If root wants to shoot himself in the head by mlocking all of memory,
> that's not a VM problem, that's a stupid administrator problem.

The kernel limits the amount of mlock()d memory to
50% of RAM, so we _should_ be ok.

(yes, this limit is per process, but daniel only
has one process running anyway)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

