Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273303AbRI3K5u>; Sun, 30 Sep 2001 06:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273265AbRI3K5a>; Sun, 30 Sep 2001 06:57:30 -0400
Received: from mta3-svc.virgin.net ([62.253.164.43]:33437 "EHLO
	mta3-svc.virgin.net") by vger.kernel.org with ESMTP
	id <S273261AbRI3K5U>; Sun, 30 Sep 2001 06:57:20 -0400
From: Glynn Clements <glynn.clements@virgin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15286.63630.291982.555919@cerise.nosuchdomain.co.uk>
Date: Sun, 30 Sep 2001 11:48:46 +0100
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <3BB693AC.6E2DB9F4@canit.se>
	<Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
X-Mailer: VM 6.94 under 21.4 (patch 4) "Artificial Intelligence (candidate #1)" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:

> > > sorry :-) definitions of netconsole-terms:
> > >
> > > 'server': the host that is the source of the messages. Ie. the box that
> > >           runs the netconsole.o module. It serves log messages to the
> > >           client.
> > >
> > > 'client': the host that receives the messages. This box is running the
> > >           netconsole-client.c program.
> >
> > Servers is usually the thing waiting for something to be sent to it,
> > the client is the sending part(initiator). this works for web servers
> > , X servers, log servers but strangley not for netconsole where
> > everything is backwards.
> 
> Owww crap.  The majority of web traffic is _from_ the
> server _to_ the client. Same for ftp, realaudio, etc...

... whereas with SMTP, syslog, printer (lpd) etc, it's the other way
around. Some servers are primarily "sources", while others are
primarily "sinks". Sources are more common, and most users are
probably more familiar with sources than sinks.

> In fact, usually the server is the _remote_ machine and
> the client is the _local_ machine.

But not for for X, NAS, ident ...

Local is a relative term. Presumably you meant local relative to a
user.

There are all kinds of generalisations one could make about individual
protocols, none of which are ultimately relevant to the client/server
distinction.

As Ingo points out, although it could have been more clear, the actual
distinction between client and server is that the client initiates the
communication, while the server responds (cf "originate" and "answer"
in telephone terminology).

-- 
Glynn Clements <glynn.clements@virgin.net>
