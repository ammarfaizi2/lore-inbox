Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVKKTNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVKKTNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVKKTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:13:50 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:53458 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751072AbVKKTNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:13:49 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 19:13:41 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dl2qh5$and$1@taverner.CS.Berkeley.EDU>
References: <200511102334.10926.cloud.of.andor@gmail.com> <dl18ro$l0f$1@taverner.CS.Berkeley.EDU> <1131736199.5758.27.camel@mindpipe>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1131736421 10989 128.32.168.222 (11 Nov 2005 19:13:41 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Fri, 11 Nov 2005 19:13:41 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell  wrote:
>On Fri, 2005-11-11 at 05:06 +0000, David Wagner wrote:
>> Probably only super-user should be permitted to read the usage information
>> about other processes.
>
>Why restrict it to root?  Why not just prevent users from reading other
>users rusage.  How could it be a security hole for joeuser's process be
>able to read the rusage of joeuser's other processes?

Sorry; you're absolutely right.  I agree.  I overlooked that case.
