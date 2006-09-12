Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWILTmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWILTmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 15:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWILTmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 15:42:17 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:49296 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1030389AbWILTmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 15:42:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Tue, 12 Sep 2006 19:42:07 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee72if$sng$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv> <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org> <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158090127 29424 128.32.168.222 (12 Sep 2006 19:42:07 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Tue, 12 Sep 2006 19:42:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett  wrote:
>Please see these threads and quit bringing up this topic like crazy:
>http://marc.theaimsgroup.com/?l=linux-kernel&m=113304241100330&w=2
>http://marc.theaimsgroup.com/?l=linux-kernel&m=114635639325551&w=2

I've read those threads in detail.  Those threads give no justification
whatsoever about why the files are stored in tar with world-writeable
permissions.  The posts to those threads just blame the victim, blame
the maintainers of tar, and point fingers at everyone else.  I cannot
see any good reason why the files in tar need to have world-writeable
permissions.  It seems to me like a simple and reasonable request to make
them non-world-writeable.  It can't hurt, and it might help a few users.
I cannot fathom why there is such resistance to such a simple request.

Just because it is a bug in tar doesn't mean that Linux developers have
to create their tarfile in a way that tickles the bug.  Two wrongs don't
make a right.

Just because it doesn't affect you doesn't mean that it isn't an issue.
You're not the only person in the world.
