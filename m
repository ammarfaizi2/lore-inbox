Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271935AbRIIJnF>; Sun, 9 Sep 2001 05:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271936AbRIIJm4>; Sun, 9 Sep 2001 05:42:56 -0400
Received: from home.nohrsc.nws.gov ([192.46.108.2]:53212 "HELO nohrsc.nws.gov")
	by vger.kernel.org with SMTP id <S271935AbRIIJmn>;
	Sun, 9 Sep 2001 05:42:43 -0400
Date: Sun, 9 Sep 2001 04:42:59 -0500 (CDT)
From: kelley eicher <keicher@nws.gov>
X-X-Sender: <keicher@home.nohrsc.nws.gov>
To: <linux-kernel@vger.kernel.org>
cc: <keicher@nws.gov>
Subject: 2.4.9-10pre4 kernel: __alloc_pages errors
Message-ID: <Pine.LNX.4.33.0109090412220.11522-100000@home.nohrsc.nws.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i've been using the 2.4.9-10pre4 kernel on various intel i686 servers as
of late and the result is log files filled with messages similar to the
following:

-

Sep  9 00:49:22 ofs1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x70/1).
Sep  9 00:50:07 ofs1 last message repeated 153 times
Sep  9 00:50:07 ofs1 kernel: cation failed (gfp=0x70/1).
Sep  9 00:50:07 ofs1 kernel: __alloc_pages: 0-order allocation failed
(gfp=0x70/1).
Sep  9 00:50:07 ofs1 last message repeated 69 times

-

this is happening constantly on machines with heavy filesystem activity
and frequently on machines with less filesystem activity.

i have read some of the recent email regarding '__alloc_pages' errors and
see that `kswapd` is a matter of discussion. on my servers, this process
seems to eat a ton of cpu time until the machine crashes. so far i have seen
some machines crash completely. i.e. no response from network or console. i
have seen others die incompletely. i.e. fail to repond to `sync` and `reboot`
most notably but are mostly available for system use otherwise<including
network services>.

does anyone have any thoughts or suggestions for me regarding this
situation? many many more details about hardware or system configuration
can be provided if necessary.

thanx in advance for any response,
-kelley

ps: please keep my email<keicher@nws.gov> carbon copied as i am not
currently on this list. thanx...

