Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRI3MZt>; Sun, 30 Sep 2001 08:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273361AbRI3MZk>; Sun, 30 Sep 2001 08:25:40 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:32999 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S273349AbRI3MZZ>; Sun, 30 Sep 2001 08:25:25 -0400
Date: Sun, 30 Sep 2001 06:25:33 -0600
Message-Id: <200109301225.f8UCPXl16936@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Kenneth Johansson <ken@canit.se>, <mingo@elte.hu>,
        "Randy.Dunlap" <rddunlap@osdlab.org>,
        Andreas Dilger <adilger@turbolabs.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <netdev@oss.sgi.com>
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
In-Reply-To: <3BB693AC.6E2DB9F4@canit.se>
	<Pine.LNX.4.33L.0109300448210.19147-100000@imladris.rielhome.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
> Owww crap.  The majority of web traffic is _from_ the
> server _to_ the client. Same for ftp, realaudio, etc...
> 
> In fact, usually the server is the _remote_ machine and
> the client is the _local_ machine. Anybody who believes
> in having the client remote and the server local should
> be shipped off to whereever the server is ;)

Let's see, with X, the server is local (at least, it's local to where
I've placed my ass) and the client is remote.

I usually think of "server" as the box that's running all the time,
providing a service to multiple clients. In this case, the netconsole
server should always be running, accepting log messages for
storage. The clients (which are transitory, otherwise netconsole
wouldn't be needed:-), initiate work for the server to do.

Face it, Ingo's use of "client" and "server" is contrary to accepted
usage. You can't finesse around it.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
