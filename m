Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVAIWdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVAIWdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVAIWdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 17:33:03 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:36876 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261869AbVAIWdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 17:33:02 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [PATCH] kernel/printk.c  lockless access
Date: Sun, 9 Jan 2005 22:31:26 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <crsbbu$lkq$1@abraham.cs.berkeley.edu>
References: <20050106195812.GL22274@austin.ibm.com> <41DDD6FA.2050403@osdl.org> <1105062162.24896.311.camel@localhost.localdomain> <20050109104425.GA9524@janus>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1105309886 22170 128.32.168.222 (9 Jan 2005 22:31:26 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Sun, 9 Jan 2005 22:31:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen  wrote:
>What about UDP (or just eth) broadcasting the oops and catching it
>on another system?

For security reasons, it better be optional and disabled by default.
(That should be easy enough to ensure, so this is obviously not something
to stand in the way of doing something like this.)
