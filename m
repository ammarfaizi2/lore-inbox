Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272980AbRI3Hxs>; Sun, 30 Sep 2001 03:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272991AbRI3Hxj>; Sun, 30 Sep 2001 03:53:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60937 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S272980AbRI3HxX>;
	Sun, 30 Sep 2001 03:53:23 -0400
Date: Sun, 30 Sep 2001 04:52:49 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Kenneth Johansson <ken@canit.se>
Cc: <mingo@elte.hu>, "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <3BB693AC.6E2DB9F4@canit.se>
Message-ID: <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, Kenneth Johansson wrote:
> Ingo Molnar wrote:
>
> > sorry :-) definitions of netconsole-terms:
> >
> > 'server': the host that is the source of the messages. Ie. the box that
> >           runs the netconsole.o module. It serves log messages to the
> >           client.
> >
> > 'client': the host that receives the messages. This box is running the
> >           netconsole-client.c program.
>
> Servers is usually the thing waiting for something to be sent to it,
> the client is the sending part(initiator). this works for web servers
> , X servers, log servers but strangley not for netconsole where
> everything is backwards.

Owww crap.  The majority of web traffic is _from_ the
server _to_ the client. Same for ftp, realaudio, etc...

In fact, usually the server is the _remote_ machine and
the client is the _local_ machine. Anybody who believes
in having the client remote and the server local should
be shipped off to whereever the server is ;)

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

