Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269752AbRHYQfA>; Sat, 25 Aug 2001 12:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269763AbRHYQev>; Sat, 25 Aug 2001 12:34:51 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11020 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269752AbRHYQek>;
	Sat, 25 Aug 2001 12:34:40 -0400
Date: Sat, 25 Aug 2001 13:34:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010825182815.K773@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108251333360.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2001, Marc A. Lehmann wrote:
> On Sat, Aug 25, 2001 at 12:50:51PM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> > Remember NL.linux.org a few weeks back, where a difference of
> > 10 FTP users more or less was the difference between a system
> > load of 3 and a system load of 250 ?  ;)
>
> OTOH, servers the use a single process or thread per connection are
> destined to fail under load ;)

That wouldn't have made a big difference in this case, except that
one process doing readahead window thrashing with its own readahead
data would have fallen over even worse ...

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

