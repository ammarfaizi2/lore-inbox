Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132108AbRCVRBR>; Thu, 22 Mar 2001 12:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132109AbRCVRBH>; Thu, 22 Mar 2001 12:01:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12306 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132101AbRCVRAz>; Thu, 22 Mar 2001 12:00:55 -0500
Date: Thu, 22 Mar 2001 13:29:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Tom Kondilis <tomk@plaza.ds.adp.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <4605B269DB001E4299157DD1569079D2809930@EXCHANGE03.plaza.ds.adp.com>
Message-ID: <Pine.LNX.4.21.0103221329000.21415-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Tom Kondilis wrote:

> I had a 2.4.3pre3 do a 'Killing Init'
> My assuption is that I had a large benchmark running, while the benchmark
> was running,  I updated inittab to uncomment a mgetty of my serial port, and
> followed it with a 'telinit q'.
> When the system thought it ran out of memory with '1-order allocation
> failures' during a fork, which I think its a defect , because I still have
> 14GB of Swap left in the system. My system was dead.
> A real life case of killing Init.

That's not the OOM killer however, but init dying because it
couldn't get the memory it needed to satisfy a page fault or
somesuch...

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

