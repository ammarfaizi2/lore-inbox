Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261566AbSKDJY4>; Mon, 4 Nov 2002 04:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbSKDJY4>; Mon, 4 Nov 2002 04:24:56 -0500
Received: from main.gmane.org ([80.91.224.249]:44171 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261566AbSKDJY4>;
	Mon, 4 Nov 2002 04:24:56 -0500
To: linux-kernel@vger.kernel.org
X-Injected-Via-Gmane: http://gmane.org/
Path: pressi.com!nobody
From: Antti Salmela <asalmela@iki.fi>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 4 Nov 2002 11:25:08 +0200
Message-ID: <slrnascf7j.5nn.asalmela@pan.pressi.com>
References: <Pine.GSO.4.21.0211030048170.25010-100000@steklov.math.psu.edu> <1036307763.31699.214.camel@thud>
NNTP-Posting-Host: poseidon.pressi.com
X-Trace: main.gmane.org 1036401839 983 194.100.77.228 (4 Nov 2002 09:23:59 GMT)
X-Complaints-To: usenet@main.gmane.org
NNTP-Posting-Date: Mon, 4 Nov 2002 09:23:59 +0000 (UTC)
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dax Kelson <dax@gurulabs.com> wrote:

> Each app should run in its own security context by itself.  That is why
> I have all the following users in my /etc/passwd:
> 
> apache nscd squid xfs ident rpc pcap nfsnobody radvd gdm named ntp

Well, wouldn't it be then logical to associate uids to capabilities, e.g. I
could have ping binary setuid to user ping which would have just the
necessary capabilities to operate?

-- 
Antti Salmela


