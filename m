Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUALPMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266190AbUALPMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:12:06 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:12163
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S266189AbUALPME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:12:04 -0500
Subject: Re: 2.6.0 NFS-server low to 0 performance
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073917652.1639.21.camel@nidelv.trondhjem.org>
References: <Pine.LNX.4.44.0401101143280.2363-100000@poirot.grange>
	 <1073745028.1146.13.camel@nidelv.trondhjem.org>
	 <btt971$3p8$1@gatekeeper.tmr.com>
	 <1073917652.1639.21.camel@nidelv.trondhjem.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073920323.1639.28.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 12 Jan 2004 10:12:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The 8k limit that you find in RFC1094 was an ad-hoc "limit" based purely
> on testing using pre-1989 hardware. AFAIK most if not all of the
> commercial vendors (Solaris, AIX, Windows/Hummingbird, EMC and Netapp)
> are all currently setting the defaults to 32k block sizes for both TCP
> and UDP.
> Most of them want to bump that to a couple of Mbyte in the very near
> future.

Note: the future Mbyte sizes can, of course, only be supported on TCP
since UDP has an inherent limit at 64k. The de-facto limit on UDP is
therefore likely to remain at 32k (although I think at least one vendor
has already tried pushing it to 48k).

Trond
