Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVBHOf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVBHOf1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 09:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVBHOf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 09:35:26 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:13579 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261538AbVBHOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 09:35:18 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] BSD Secure Levels: claim block dev in file struct rather than inode struct, 2.6.11-rc2-mm1 (3/8)
Date: Tue, 8 Feb 2005 14:33:07 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cuaij3$63h$1@abraham.cs.berkeley.edu>
References: <20050207192108.GA776@halcrow.us> <200502072241.j17MfTfP027969@turing-police.cc.vt.edu> <cu95po$3ch$1@abraham.cs.berkeley.edu> <200502080210.j182Aioh007619@turing-police.cc.vt.edu>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1107873187 6257 128.32.168.222 (8 Feb 2005 14:33:07 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Tue, 8 Feb 2005 14:33:07 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The attack is to hardlink some tempfile name to some file you want
>over-written.  This usually involves just a little bit of work, such as
>recognizing that a given root cronjob uses an unsafe predictable filename
>in /tmp (look at the Bugtraq or Full-Disclosure archives, there's plenty).
>Then you set a little program that sleep()s till a few seconds before
>the cronjob runs, does a getpid(), and then sprays hardlinks into the
>next 15 or 20 things that mktemp() will generate...

Got it.  Very good -- now I see.  Thanks for the explanation.
