Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269210AbRHLOBH>; Sun, 12 Aug 2001 10:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269211AbRHLOA6>; Sun, 12 Aug 2001 10:00:58 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:44042 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269210AbRHLOAu>;
	Sun, 12 Aug 2001 10:00:50 -0400
Date: Sun, 12 Aug 2001 11:00:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Galbraith <mikeg@wen-online.de>, Steve Kieu <haiquy@yahoo.com>,
        kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance 2.4.8 is worse than 2.4.x<8
In-Reply-To: <E15VtnT-0005bM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33L.0108121053430.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Aug 2001, Alan Cox wrote:

> > Here, disk write throughput seems to want some tweaking, and Bonnie
> > doing it's rewrite test triggers a very large and persistant inactive
> > shortage which shouldn't be there (imho).
>
> This is one of the reasons I kept the 2.4.7 vm. The 2.4.8 vm is better
> than 2.4.8pre but not actually better than the older VM by feel or
> measurement on my test boxes

There are some open-ended questions wrt. the use-once idea,
its implementation and the way the thing has been integrated
with the rest of the kernel.

Some suspect interactions and some things which just aren't
clear yet don't make it seem the best idea to start integrating
the use-once idea in mainli^W-ac yet...

regards,

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

