Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbTLDTV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 14:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbTLDTV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 14:21:27 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:27411 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S263510AbTLDTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 14:21:25 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: partially encrypted filesystem
Date: Thu, 4 Dec 2003 19:18:26 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bqo1a2$s8i$1@abraham.cs.berkeley.edu>
References: <1070485676.4855.16.camel@nucleon> <20031204141725.GC7890@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312040712270.2055@home.osdl.org> <20031204172653.GA12516@wohnheim.fh-wedel.de>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1070565506 28946 128.32.153.228 (4 Dec 2003 19:18:26 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Thu, 4 Dec 2003 19:18:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel  wrote:
>Depends on how much security you really care about.  If you really
>don't mind the pain involved, some metadata should explicitly *not* be
>encrypted, to avoid known plaintext attacks.

What?  No.  Modern cryptosystems are designed to be secure against
known plaintext attacks.  Making your system more convoluted merely to
avoid providing known plaintext is a lousy design approach: the extra
complexity usually adds more risk than it removes.
