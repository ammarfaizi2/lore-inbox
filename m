Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUH0RiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUH0RiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266727AbUH0RiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:38:10 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:3464 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264697AbUH0RiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:38:01 -0400
Subject: Re: POSIX_FADV_NOREUSE and O_STREAMING behavior in 2.6.7
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Greaves <david@dgreaves.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <412EEFF1.9080409@dgreaves.com>
References: <412E2058.60302@rtlogic.com>  <412E2E0D.8040401@dgreaves.com>
	 <1093547459.6106.57.camel@lade.trondhjem.org>
	 <412EEFF1.9080409@dgreaves.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093628279.5758.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 13:37:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 27/08/2004 klokka 04:25, skreiv David Greaves:
> I want my nfs client to communicate this to my nfs server. Thus avoiding 
> my nfs server having a cache of useless video.
> I can see this becoming an important benefit for video distribution (an 
> area linux is likely to see more of)

Then that will have to be done either through some out-of-band protocol,
or as part of some future minor revision of NFSv4 (assuming that you are
able to make a good case for it in an RFC and present it to the IETF's
NFS working group).

Cheers,
  Trond
