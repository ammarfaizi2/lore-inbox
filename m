Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSEYXkw>; Sat, 25 May 2002 19:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315451AbSEYXjt>; Sat, 25 May 2002 19:39:49 -0400
Received: from bs1.dnx.de ([213.252.143.130]:57514 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315452AbSEYXjq>;
	Sat, 25 May 2002 19:39:46 -0400
Date: Sun, 26 May 2002 00:33:59 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526003359.Z598@schwebel.de>
In-Reply-To: <20020525110830.U598@schwebel.de> <Pine.LNX.4.44.0205251025010.6515-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 10:27:24AM -0700, Linus Torvalds wrote:
> It results in the fact that you need to have a _clear_interface_ between
> the hard realtime parts, and the stuff that isn't.

Show me how you will implement a closed loop controller where the
application is _not_ implemented as a kernel module. I would really love to
do it this way, but unfortunately no one of the realtime programmers has
found a way how it can be achieved so far. 

> Yes, that does imply a certain amount of good design. And it requires you
> to understand which parts are time-critical, and which aren't.

Unfortunately, in the automation field nearly all applications are
closed-loop, and that means that the application itself is time critical. 

> > This is only correct for open-loop applications. Most real life apps are
> > closed-loop.
> 
> Most real life apps have nothing to do with hard-RT.

Perhaps in your life :-) It's different in mine, in Karim's, Wolfgang's,
Bernhard's, Steve's, Stuart's, Paolo's, Guennadi's, Thomas', Massimo's,
Pierre's, Lorenzo's, Giuseppe's, Erwin's, Dave's, Ian's, Alex' (just to
mention the RTAI team) and in that of all the thousands of engineers who
are working with Linux and RTAI every day. 

Please, take into account that there are people out there wo are working
with Linux in automation and control applications every day, and their
bread and butter _is_ realtime stuff. My experience is that this is
sometimes really hard to understand for people who normally work on
problems from the IT industry, you are not the only one.

Realtime may be someting exotic for "normal" PC users, but in the whole
industrial embedded world it is completely different. 

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
