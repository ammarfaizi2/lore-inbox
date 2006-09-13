Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751574AbWIMFeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbWIMFeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 01:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbWIMFeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 01:34:19 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:46248 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751570AbWIMFeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 01:34:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: R: Linux kernel source archive vulnerable
Date: Wed, 13 Sep 2006 05:34:01 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ee8589$e70$1@taverner.cs.berkeley.edu>
References: <20060907182304.GA10686@danisch.de> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu> <20060913043319.GH541@1wt.eu>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1158125641 14560 128.32.168.222 (13 Sep 2006 05:34:01 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 13 Sep 2006 05:34:01 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau  wrote:
>The initial reason is that Linus now uses the "git-tar-tree" command
>which creates the full tar archive from the tree. It does not use tar,
>it know how to produce the tar format itself. The command has to set
>permissions on the files, and by default, it sets full permissions to
>the files.

Ahh, thanks for the explanation.  That's helpful.

So it sounds like git-tar-tree has a bug; its default isn't setting
meaningful permissions on the files that it puts into the tar archive.
I hope the maintainers of git-tar-tree will consider fixing this bug.
