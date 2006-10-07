Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWJGPAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWJGPAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJGPAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:00:36 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:26013 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S932156AbWJGPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:00:35 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] honour MNT_NOEXEC for access()
Date: Sat, 7 Oct 2006 15:00:30 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg8fee$lpc$1@taverner.cs.berkeley.edu>
References: <4516B721.5070801@redhat.com> <1160170464.12835.4.camel@localhost.localdomain> <4526C7F4.6090706@redhat.com> <45278D2A.4020605@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1160233230 22316 128.32.168.222 (7 Oct 2006 15:00:30 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Sat, 7 Oct 2006 15:00:30 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>Now, as the access(X_OK) is fixed, would it be
>feasible for ld.so to start using it?

access() has TOCTTOU vulnerabilities, and should not be used for
any security-critical purpose...
