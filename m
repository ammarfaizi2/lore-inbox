Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265553AbUAJWy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAJWy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:54:27 -0500
Received: from [193.138.115.2] ([193.138.115.2]:21774 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265553AbUAJWyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:54:15 -0500
Date: Sat, 10 Jan 2004 23:51:08 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange>
Message-ID: <Pine.LNX.4.56.0401102346160.13633@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Jan 2004, Guennadi Liakhovetski wrote:

> On Sat, 10 Jan 2004, Trond Myklebust wrote:
>
> > P? lau , 10/01/2004 klokka 15:04, skreiv Guennadi Liakhovetski:
> > > Not change - keep (from 2.4). You see, the problem might be - somebody
> > > updates the NFS-server from 2.4 to 2.6 and then suddenly some clients fail
> > > to work with it. Seems a non-obvious fact, that after upgrading the server
> > > clients' configuration might have to be changed. At the very least this
> > > must be documented in Kconfig.
> >
> > Non-obvious????? You have to change modutils, you have to upgrade
> > nfs-utils, glibc, gcc... and that's only the beginning of the list.
> >
> > 2.6.x is a new kernel it differs from 2.4.x, which again differs from
> > 2.2.x, ... Get over it! There are workarounds for your problem, so use
> > them.
>
> Please, calm down:-)), I am not fighting, I am just thinking aloud, I have
> no intention whatsoever to attack your aor anybody else's work / ideas /
> decisions, etc.
>
> The only my doubt was - yes, you upgrade the __server__, so, you look in
> Changes, upgrade all necessary stuff, or just upgrade blindly (as does
> happen sometimes, I believe) a distribution - and the server works, fine.
> What I find non-obvious, is that on updating the server you have to
> re-configure __clients__, see? Just think about a network somewhere in a
> uni / company / whatever. Sysadmins update the server, and then
> NFS-clients suddenly cannot use NFS any more...
>
Ever tried upgrading a WinNT server to Win2k or Win2003 Server? Don't
expect all your Win95, Win98 and WinNT clients to just work the same as
they did previously...
Same goes with other OSs.  Software that has requirements on both the client and
server side naturally has to be kept in sync, and NFS is not the only case
where not everything is 100% backwards compatible.
This shouldn't really be surprising.

-- Jesper Juhl

