Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVDPBat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVDPBat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVDPBat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:30:49 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:26639 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262549AbVDPBai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:30:38 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 01:28:40 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3ppo8$4m5$3@abraham.cs.berkeley.edu>
References: <20050415162225.GA23277@certainkey.com> <20050415165036.16224.qmail@science.horizon.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113614920 4805 128.32.168.222 (16 Apr 2005 01:28:40 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 01:28:40 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux wrote:
>/dev/urandom depends on the strength of the crypto primitives.
>/dev/random does not.  All it needs is a good uniform hash.

That's not at all clear.  I'll go farther: I think it is unlikely
to be true.

If you want to think about cryptographic primitives being arbitrarily
broken, I think there will be scenarios where /dev/random is insecure.

As for what you mean by "good uniform hash", I think you'll need to
be a bit more precise.

>Do a bit of reading on the subject of "unicity distance".

Yes, I've read Shannon's original paper on the subject, as well
as many other treatments.

I stand by my comments above.
