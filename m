Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUAPGyH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbUAPGyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:54:07 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:13221 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265290AbUAPGyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:54:05 -0500
Date: Thu, 15 Jan 2004 22:53:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040116065347.GI1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange> <1073745028.1146.13.camel@nidelv.trondhjem.org> <btt971$3p8$1@gatekeeper.tmr.com> <1073917652.1639.21.camel@nidelv.trondhjem.org> <1073920323.1639.28.camel@nidelv.trondhjem.org> <20040116054449.GH1748@srv-lnx2600.matchmail.com> <1074233145.1996.19.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074233145.1996.19.camel@nidelv.trondhjem.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 01:05:45AM -0500, Trond Myklebust wrote:
> P? fr , 16/01/2004 klokka 00:44, skreiv Mike Fedyk:
> > Does the RPC max size limit change with memory or filesystem?
> > 
> > I have one system (K7 2200, 1.5GB, ext3) where it uses 32K RPCs, and another
> > (P2 300, 168MB, reiserfs3) and it uses 8k RPCs, even if I request larger max
> > sizes, and they're both running 2.6.1-bk2.
> 
> The maximum allowable size is set by the server. If the server is
> running 2.6.1, then it should normally support 32k reads and writes
> (unless there is a bug somewhere).

The two systems above are nfs servers.

Mike
