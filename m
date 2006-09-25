Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWIYUMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWIYUMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWIYUMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:12:17 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:19181 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1750993AbWIYUMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:12:16 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Mon, 25 Sep 2006 20:12:06 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <ef9d6m$chs$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <1159059219.3093.276.camel@laptopd505.fenrus.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159215126 12860 128.32.168.222 (25 Sep 2006 20:12:06 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Mon, 25 Sep 2006 20:12:06 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven  wrote:
>[...]  so you remove a security check ... [...]
>
>If you can mmap PROT_EXEC the "noexec" mount option doesn't mean
>anything! Because a elf binary loader is easily written in
>perl/shell/whatever, the kernel "x" bit is just a convenience there!
>The PROT_EXEC check at least makes it a bit harder to do anything like
>this; not impossible obviously

The last sentence of your post implies that this never was a security
check.  (I'll believe it was a check to prevent some kinds of accidental
misbehavior, but I don't believe it prevents deliberate misbehavior.)
