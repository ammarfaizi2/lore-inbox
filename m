Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266543AbUH0RV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266543AbUH0RV4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 13:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266617AbUH0RV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 13:21:56 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:7814 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266543AbUH0RVy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 13:21:54 -0400
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
Message-Id: <1093627313.5758.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 27 Aug 2004 13:21:53 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 27/08/2004 klokka 04:25, skreiv David Greaves:

> I want my nfs client to communicate this to my nfs server. Thus avoiding 
> my nfs server having a cache of useless video.
> I can see this becoming an important benefit for video distribution (an 
> area linux is likely to see more of)

Then you are probably going to have to invent some out-of-band protocol
in order to do so. Creating such a protocol shouldn't be a hard task,
but getting all those server manufacturers to adopt it afterwards
probably will be be. ;-)

Alternatively, if you can make a good case (and write a decent RFC), you
might be able to persuade the IETF working group to add this feature
into a future minor version of NFSv4.

Cheers,
  Trond
