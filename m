Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKKXow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKKXow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKKXov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:44:51 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:37254 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750714AbVKKXou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:44:50 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] getrusage sucks
Date: Fri, 11 Nov 2005 23:44:39 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dl3ad7$ikf$2@taverner.CS.Berkeley.EDU>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com> <200511112338.20684.cloud.of.andor@gmail.com> <1131751433.3174.50.camel@localhost.localdomain> <20051111230223.GB7991@shell0.pdx.osdl.net>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1131752679 19087 128.32.168.222 (11 Nov 2005 23:44:39 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Fri, 11 Nov 2005 23:44:39 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright  wrote:
>It's already available via /proc w/out protection.  And ditto via posix
>cpu timers.

If so, maybe that code should be fixed.  Where exactly in /proc would
I find the getrusage() info of another process?  Is there any argument
that disclosing it to everyone is safe?  Or is it just that no one has
ever given the security considerations much thought up till now?
