Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268715AbRG3Wy7>; Mon, 30 Jul 2001 18:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268712AbRG3Wyx>; Mon, 30 Jul 2001 18:54:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:51723 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269126AbRG3Wxd>; Mon, 30 Jul 2001 18:53:33 -0400
Date: Mon, 30 Jul 2001 19:53:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@caldera.de>, <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <3B65E177.D77ACA45@namesys.com>
Message-ID: <Pine.LNX.4.33L.0107301946380.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Hans Reiser wrote:
> Rik van Riel wrote:
> > On Tue, 31 Jul 2001, Hans Reiser wrote:

> > > The cost is not a crash, the cost is performance sucks.
> >
> > If you can chose between sucky performance or a chance
> > at silent data corruption ... which would you chose ?
>
> If you could halve linux memory manager performance and check as
> many things as reiserfs checks, would you do it.

I haven't removed a single debugging check from the
2.4 VM. Performance is MUCH more reliant on things
like evicting the right page from RAM or reading in
the right page at the right time.

CPU usage is only secondary.

> .. You made the right choice.

Thanks ;)    [yeah, yeah ... flame me about out-of-context]


> Now, if you add a #define, you can check as many things as
> ReiserFS checks, and still go just as fast....

I'm sure these checks make reiserfs a tad more CPU hungry,
but isn't the real win in reiserfs supposed to come from
superior disk layout, readahead across files, etc... ?

Or is that all just a myth ?

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

