Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319305AbSHVDjc>; Wed, 21 Aug 2002 23:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319306AbSHVDjc>; Wed, 21 Aug 2002 23:39:32 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:49932 "EHLO
	mx2.cypherpunks.ca") by vger.kernel.org with ESMTP
	id <S319305AbSHVDjc>; Wed, 21 Aug 2002 23:39:32 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Date: 22 Aug 2002 03:27:16 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <ak1lmk$drl$4@abraham.cs.berkeley.edu>
References: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com> <Pine.LNX.4.44.0208172019130.1537-100000@home.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1029986836 14197 128.32.153.211 (22 Aug 2002 03:27:16 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 22 Aug 2002 03:27:16 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  wrote:
>There are _real_ reasons why a firewall box (ie one
>that probably comes with a flash memory disk, and runs a small web-server
>for configuration) would want to have strong random numbers (exactly for
>things like generating host keys when asked to by the sysadmin), yet you
>seem to say that such a user would have to use /dev/urandom.

Such users should be using /dev/urandom anyway.
Most apps I've seen that use /dev/random do so out of confusion,
not because /dev/random is the right thing to use.
