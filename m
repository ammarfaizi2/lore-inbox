Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274708AbRJAHmI>; Mon, 1 Oct 2001 03:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274709AbRJAHl7>; Mon, 1 Oct 2001 03:41:59 -0400
Received: from chiara.elte.hu ([157.181.150.200]:20498 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S274708AbRJAHlq>;
	Mon, 1 Oct 2001 03:41:46 -0400
Date: Mon, 1 Oct 2001 09:39:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Marcus Sundberg <marcus@cendio.se>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <ven13cd5yt.fsf@inigo.sthlm.cendio.se>
Message-ID: <Pine.LNX.4.33.0110010936240.3436-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 30 Sep 2001, Marcus Sundberg wrote:

> > sorry :-) definitions of netconsole-terms:
> >
> > 'server': the host that is the source of the messages. Ie. the box that
> >           runs the netconsole.o module. It serves log messages to the
> >           client.
> >
> > 'client': the host that receives the messages. This box is running the
> >           netconsole-client.c program.
>
> Then I guess you consider Mozilla to be a http-server, as it serves
> http-requests to http-clients like Apache? ;)

no. Mozilla is a http-client, it sends requests to the Apache http-server
and it receives content produced by the server.

the netconsole-module box is a log-server that sends messages to the
log-client, which log content is produced by the netconsole-module box.
(right now it gets not requests from the client, but it will so in the
future.)

(and yes, occasionally Mozilla is the content server, think cookies ...)

	Ingo

