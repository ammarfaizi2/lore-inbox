Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRGBCDd>; Sun, 1 Jul 2001 22:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263400AbRGBCDX>; Sun, 1 Jul 2001 22:03:23 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:43025 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262655AbRGBCDF>;
	Sun, 1 Jul 2001 22:03:05 -0400
Date: Sun, 1 Jul 2001 23:02:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Removal of PG_marker scheme from 2.4.6-pre
In-Reply-To: <Pine.LNX.4.21.0106301628570.3394-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33L.0107012301460.19985-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, Marcelo Tosatti wrote:

> In pre7:
>
> "me: undo page_launder() LRU changes, they have nasty side effects"
>
> Can you be more verbose about this ?

I think this was fixed by the GFP_BUFFER vs. GFP_CAN_FS + GFP_CAN_IO
thing and Linus accidentally backed out the wrong code ;)

cheers,
Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

