Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276589AbRI2Sr3>; Sat, 29 Sep 2001 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276592AbRI2SrU>; Sat, 29 Sep 2001 14:47:20 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:53258 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S276589AbRI2SrF>;
	Sat, 29 Sep 2001 14:47:05 -0400
Date: Sat, 29 Sep 2001 15:46:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 VM, active cache pages, and OOM
In-Reply-To: <9p54c2$836$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0109291545570.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Linus Torvalds wrote:

> (which basically says: we only mark the page accessed if we read the
> _beginning_ of the page, or if we just did a seek to it)

That should work for linear IO, but I fear what influence
such a thing would have on eg. database indexes ;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

