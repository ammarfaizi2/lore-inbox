Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272038AbRIVUSa>; Sat, 22 Sep 2001 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272062AbRIVUSU>; Sat, 22 Sep 2001 16:18:20 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:25363 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272038AbRIVUSK>;
	Sat, 22 Sep 2001 16:18:10 -0400
Date: Sat, 22 Sep 2001 17:18:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Peter Magnusson <iocc@linux-kernel.flashdance.cx>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L2.0109222158180.26508-100000@flashdance>
Message-ID: <Pine.LNX.4.33L.0109221713170.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2001, Peter Magnusson wrote:

> It treats the file system cache as important as normal programs and
> thats is very wrong. Its like this on all kernels over 2.4.7.

Nope, it was a bug in the page aging which caused the system
to treat file system cache as MORE important than programs.

I think I may have fixed that bug recently, I'm waiting for
Alan to run out of critical bugfixes so he has a suitable
moment to integrate it into -ac ;)

Until then, you can get the page aging patch from my home
page: http://www.surriel.com/patches/

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

