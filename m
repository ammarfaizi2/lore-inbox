Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266506AbUAIKXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 05:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUAIKV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 05:21:26 -0500
Received: from mail.gmx.de ([213.165.64.20]:60583 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266492AbUAIKTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 05:19:17 -0500
X-Authenticated: #20450766
Date: Fri, 9 Jan 2004 11:08:29 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: linux-kernel@vger.kernel.org, Sam Vilain <sam@hydro.gen.nz>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <Pine.LNX.4.44.0401071947270.2922-100000@poirot.grange>
Message-ID: <Pine.LNX.4.44.0401091031010.18195-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Fedyk wrote:

> Just post a few samples of the lines that differ.  Any files should be sent
> off-list.

Ok, This is the problem:

10:38:30.867306 0:40:f4:23:ac:91 0:50:bf:a4:59:71 ip 590: tuxscreen.grange > poirot.grange: icmp: ip reassembly time exceeded [tos 0xc0]

A similar effect was reported in 1999 with kernel 2.3.13, also between 2
100mbps cards. It also was occurring with UDP NFS:

http://www.ussg.iu.edu/hypermail/linux/net/9908.2/0039.html

But there were no answers, so, I am CC-ing Sam, hoping to hear, if he's
found the reason and a cure for his problem. Apart from this message I
didn't find any other relevant hits with Google.

Is it some physical network problem, which somehow only becomes visible
under 2.6 now, with UDP (NFS) with 100mbps?

Guennadi
---
Guennadi Liakhovetski

