Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031223AbWI0XLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031223AbWI0XLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 19:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031228AbWI0XLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 19:11:09 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:12217 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1031223AbWI0XLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 19:11:07 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 27 Sep 2006 23:10:55 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eff0dv$poj$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159398655 26387 128.32.168.222 (27 Sep 2006 23:10:55 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 27 Sep 2006 23:10:55 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven  wrote:
>but really again you are degrading what noexec means.

As far as I can tell, noexec never really did mean anything particularly
coherent in the first place, so I find it hard to get upset about any
potential degradation.

(Second, as far as I can tell, it sounds like it may be more accurate
to characterize this as "revert some of it back to the way the semantics
were a year ago" than as "degrade noexec".  But even if it is a degradation,
I fail to see why that is a problem.)

Have you read my other email?  I notice that things got awfully quiet
on this thread once I started asking some pointed questions about what
exactly noexec is trying to solve and what exactly the threat model is.
I'm still waiting to hear any answers to those questions or any dispute
to my characterization of noexec.
