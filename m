Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281036AbRKCUZZ>; Sat, 3 Nov 2001 15:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281035AbRKCUZQ>; Sat, 3 Nov 2001 15:25:16 -0500
Received: from pop3.telenet-ops.be ([195.130.132.40]:48870 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S281032AbRKCUYl>; Sat, 3 Nov 2001 15:24:41 -0500
Date: Sat, 3 Nov 2001 21:24:37 +0100 (CET)
From: Dirk Moerenhout <dirk@staf.planetinternet.be>
X-X-Sender: <dmoerenh@dirk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [khttpd-users] khttpd vs tux
In-Reply-To: <Pine.LNX.4.30.0111031740300.8812-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0111032104330.608-100000@dirk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any good reasons why to run khttpd, then?
> What I need is a server serving something between 50 and 500 concurrent
> clients - each downloading at 4-8Mbps.

Are those people doing tons of requests or are they just downloading large
files? If they are downloading large files the type of serversoftware will
be the least of your problems. About anything can give you the full
bandwidth you can put out on your networkcards when you are serving few
requests and are just pushing out mass amount of data.

When it comes to serving people such huge amount of data you should also
take in mind that buying one big machine is not allways the right road to
take.

As an example say that the data you're serving is less than 36GB in total.
In that case you can easily buy 4 typical 2U rackmount servers with 9GB
RAID1/36GB RAID1, Dual CPU, enough RAM, 1Gb NIC and pay less than a 8-Way
system.  Furthermore those 4 servers give you more redundancy (one can
literally go up in smoke and you still lose only 25% power), they will in
scale better and so on and so on.

In the end, unless you are handling tons of requests, your concern should
be what hardware servers/switches/routers you need and certainly not what
software. That discussion by itself would off course get quite off topic
for lkml.

Dirk Moerenhout ///// System Administrator ///// Planet Internet NV

