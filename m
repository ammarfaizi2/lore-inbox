Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBZXwA>; Mon, 26 Feb 2001 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRBZXvu>; Mon, 26 Feb 2001 18:51:50 -0500
Received: from kanga.kvack.org ([216.129.200.3]:51217 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129274AbRBZXvc>;
	Mon, 26 Feb 2001 18:51:32 -0500
Date: Mon, 26 Feb 2001 18:47:33 -0500 (EST)
From: "Benjamin C.R. LaHaise" <blah@kvack.org>
To: "David S. Miller" <davem@redhat.com>
cc: michael@linuxmagic.com, Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com, waltje@uWalt.NL.Mugnet.ORG
Subject: Re: [UPDATE] zerocopy.. While working on ip.h stuff
In-Reply-To: <15002.58854.215318.882641@pizda.ninka.net>
Message-ID: <Pine.LNX.3.96.1010226184514.9835E-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2001, David S. Miller wrote:

> Not to my knowledge.  Routers already change the time to live field,
> so I see no reason why they can't do smart things with special IP
> options either (besides efficiency concerns :-).

A number of ISPs patch the MSS value to 1492 due to the ridiculous number
of PMTU black holes out on the net.  Since the ip header fits in the cache
of some CPUs (like the P4), this becoming a cheaper operation than ever
before.

		-ben

