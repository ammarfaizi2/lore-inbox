Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274194AbRI3VSa>; Sun, 30 Sep 2001 17:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274200AbRI3VSU>; Sun, 30 Sep 2001 17:18:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:36616 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274194AbRI3VSF>; Sun, 30 Sep 2001 17:18:05 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] netconsole-2.4.10-B1
Date: 30 Sep 2001 14:18:10 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9p826i$cuq$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain> <3BB693AC.6E2DB9F4@canit.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3BB693AC.6E2DB9F4@canit.se>
By author:    Kenneth Johansson <ken@canit.se>
In newsgroup: linux.dev.kernel
>
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
> >

This is backwards, sorry.  The host being logged is a client, the host
doing the logging is a server.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
