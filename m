Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265399AbUAJV5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 16:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbUAJV5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 16:57:40 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:42384
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265399AbUAJV5i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 16:57:38 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0401102100180.5835-100000@poirot.grange>
References: <Pine.LNX.4.44.0401102100180.5835-100000@poirot.grange>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073771855.3958.15.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 16:57:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 10/01/2004 klokka 15:04, skreiv Guennadi Liakhovetski:
> Not change - keep (from 2.4). You see, the problem might be - somebody
> updates the NFS-server from 2.4 to 2.6 and then suddenly some clients fail
> to work with it. Seems a non-obvious fact, that after upgrading the server
> clients' configuration might have to be changed. At the very least this
> must be documented in Kconfig.

Non-obvious????? You have to change modutils, you have to upgrade
nfs-utils, glibc, gcc... and that's only the beginning of the list.

2.6.x is a new kernel it differs from 2.4.x, which again differs from
2.2.x, ... Get over it! There are workarounds for your problem, so use
them.

Trond
