Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265471AbUAJWnF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 17:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbUAJWnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 17:43:05 -0500
Received: from pop.gmx.de ([213.165.64.20]:45184 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265471AbUAJWmu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 17:42:50 -0500
X-Authenticated: #20450766
Date: Sat, 10 Jan 2004 23:42:45 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <1073771855.3958.15.camel@nidelv.trondhjem.org>
Message-ID: <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Trond Myklebust wrote:

> På lau , 10/01/2004 klokka 15:04, skreiv Guennadi Liakhovetski:
> > Not change - keep (from 2.4). You see, the problem might be - somebody
> > updates the NFS-server from 2.4 to 2.6 and then suddenly some clients fail
> > to work with it. Seems a non-obvious fact, that after upgrading the server
> > clients' configuration might have to be changed. At the very least this
> > must be documented in Kconfig.
>
> Non-obvious????? You have to change modutils, you have to upgrade
> nfs-utils, glibc, gcc... and that's only the beginning of the list.
>
> 2.6.x is a new kernel it differs from 2.4.x, which again differs from
> 2.2.x, ... Get over it! There are workarounds for your problem, so use
> them.

Please, calm down:-)), I am not fighting, I am just thinking aloud, I have
no intention whatsoever to attack your aor anybody else's work / ideas /
decisions, etc.

The only my doubt was - yes, you upgrade the __server__, so, you look in
Changes, upgrade all necessary stuff, or just upgrade blindly (as does
happen sometimes, I believe) a distribution - and the server works, fine.
What I find non-obvious, is that on updating the server you have to
re-configure __clients__, see? Just think about a network somewhere in a
uni / company / whatever. Sysadmins update the server, and then
NFS-clients suddenly cannot use NFS any more...

Thanks
Guennadi
---
Guennadi Liakhovetski


