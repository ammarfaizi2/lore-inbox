Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbWJJT3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWJJT3c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWJJT3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:29:32 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:10688 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030219AbWJJT3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:29:31 -0400
Date: Tue, 10 Oct 2006 20:59:13 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <gregkh@suse.de>
cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Lever <chuck.lever@oracle.com>,
       Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC traffic
In-Reply-To: <20061010171429.GD6339@kroah.com>
Message-ID: <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org> <20061010171429.GD6339@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Some hardware uses port 664 for its hardware-based IPMI listener.  Teach
>the RPC client to avoid using that port by raising the default minimum port
>number to 665.

Eh, that does look more like a quick hack. What if there were enough
manufacturers around to use various parts, like manuf. A using 664, B using 800
and C using 1000? Then the port range would have to be cut down again and
again.


	-`J'
-- 
[A
