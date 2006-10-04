Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWJDEGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWJDEGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWJDEGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:06:25 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16280 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932285AbWJDEGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:06:24 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 03:20:10 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <efv99a$31o$3@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org> <4522B4F9.8000301@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159932010 3128 128.32.168.222 (4 Oct 2006 03:20:10 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 4 Oct 2006 03:20:10 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>Arjan van de Ven wrote:
>> then don't put noexec on /dev/shm.
>
>That's obviously possible, but I'd feel safer having
>"noexec" on *every* user-writable partition.

But why would you "feel" safer?  And why should the Linux kernel care
about how people "feel"?  The purpose of these mechanisms is not to make
people feel safer; it is to make them actually be safer.  If it isn't
actually making people safer -- if it is just to provide "warm fuzzies"
and a perception of safety -- then I don't see what business it has
going into the Linux kernel.  What threat, exactly, are you trying to
defend against?  What's your threat model?
