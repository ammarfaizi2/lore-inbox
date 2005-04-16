Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVDPBKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVDPBKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 21:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbVDPBKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 21:10:50 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:42766 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S262503AbVDPBKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 21:10:46 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Fortuna
Date: Sat, 16 Apr 2005 01:08:47 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <d3poiv$vrn$2@abraham.cs.berkeley.edu>
References: <20050414141538.3651.qmail@science.horizon.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1113613727 32631 128.32.168.222 (16 Apr 2005 01:08:47 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sat, 16 Apr 2005 01:08:47 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>First, a reminder that the design goal of /dev/random proper is
>information-theoretic security.  That is, it should be secure against
>an attacker with infinite computational power.

I am skeptical.
I have never seen any convincing evidence for this claim,
and I suspect that there are cases in which /dev/random fails
to achieve this standard.

And it seems I am not the only one.  See, e.g., Section 5.3 of:
http://eprint.iacr.org/2005/029

Fortunately, it doesn't matter whether /dev/random provides
information-theoretic security.  I have reasonable confidence that
it provides computational security, and that is all that applications
need.
