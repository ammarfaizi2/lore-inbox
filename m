Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422822AbWJLI3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422822AbWJLI3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 04:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWJLI3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 04:29:42 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:23258 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1422822AbWJLI3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 04:29:41 -0400
Date: Thu, 12 Oct 2006 09:58:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC traffic
In-Reply-To: <1160616905.6596.14.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org>  <20061010171429.GD6339@kroah.com>
  <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr> 
 <1160610353.7015.8.camel@lade.trondhjem.org>  <1160615547.20611.0.camel@localhost.localdomain>
 <1160616905.6596.14.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Interestingly, Linux is not the only OS that has been hit by this
>problem:
>
>  http://blogs.sun.com/shepler/entry/port_623_or_the_mount

There is more to it. On a machine I had set up a second,
experimental, apache on port 880. And it randomly failed to start on
a boot because mountd had taken the port first.
Man, this RPC stuff should go and use fixed ports.


	-`J'
-- 
