Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUAPGFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 01:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265289AbUAPGFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 01:05:49 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:14720
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265288AbUAPGFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 01:05:47 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040116054449.GH1748@srv-lnx2600.matchmail.com>
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
	 <1073745028.1146.13.camel@nidelv.trondhjem.org>
	 <btt971$3p8$1@gatekeeper.tmr.com>
	 <1073917652.1639.21.camel@nidelv.trondhjem.org>
	 <1073920323.1639.28.camel@nidelv.trondhjem.org>
	 <20040116054449.GH1748@srv-lnx2600.matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1074233145.1996.19.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 16 Jan 2004 01:05:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 16/01/2004 klokka 00:44, skreiv Mike Fedyk:
> Does the RPC max size limit change with memory or filesystem?
> 
> I have one system (K7 2200, 1.5GB, ext3) where it uses 32K RPCs, and another
> (P2 300, 168MB, reiserfs3) and it uses 8k RPCs, even if I request larger max
> sizes, and they're both running 2.6.1-bk2.

The maximum allowable size is set by the server. If the server is
running 2.6.1, then it should normally support 32k reads and writes
(unless there is a bug somewhere).

Cheers,
  Trond
