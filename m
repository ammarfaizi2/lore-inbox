Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTJXVBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 17:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbTJXVBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 17:01:53 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:2313 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262622AbTJXVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 17:01:51 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [RFC] frandom - fast random generator module
Date: Fri, 24 Oct 2003 20:59:42 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <bnc3ru$kab$2@abraham.cs.berkeley.edu>
References: <3F8E552B.3010507@users.sf.net> <20031022122251.A3921@borg.org> <3F97498D.9050704@storm.ca> <bnbo18$49b$1@gatekeeper.tmr.com>
Reply-To: daw@cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1067029182 20811 128.32.153.211 (24 Oct 2003 20:59:42 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 24 Oct 2003 20:59:42 +0000 (UTC)
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
>I know someone noted that frandom couldn't just replace urandom, but I
>don't recall why.

Because we don't have enough confidence in the cryptographic
security of frandom.
