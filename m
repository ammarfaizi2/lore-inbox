Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273323AbTHKTXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 15:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273019AbTHKTW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 15:22:57 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:787 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S272963AbTHKTVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 15:21:40 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Date: Mon, 11 Aug 2003 19:21:01 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bh8qat$d7i$1@abraham.cs.berkeley.edu>
References: <20030809173329.GU31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <bh77pp$rhq$1@abraham.cs.berkeley.edu> <20030811053602.GL10446@mail.jlokier.co.uk>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1060629661 13554 128.32.153.211 (11 Aug 2003 19:21:01 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Mon, 11 Aug 2003 19:21:01 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier  wrote:
>It may be that an attacker knows about a systemic problem with our
>machine that we don't know about.  For example the attacker might know
>our pool state well enough shortly after boot time, to have a chance
>at matching a dictionary of 2^32 hashes.  The attacker might have had
>a chance to read our disk, which reseeding the pool at boot time does
>not protect against.
>
>With the right algorithm, we can protect against weaknesses of this kind.

How?  No matter what we do, the outputs are going to be a deterministic
function of the state of the pool.  If the attacker can guess the entire
state of our pool (or narrow it down to 2^32 possibilities), we're screwed,
no matter what.  Right?

I must be misunderstanding your point.  What am I missing?
