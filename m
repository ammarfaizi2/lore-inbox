Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVANF6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVANF6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 00:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261894AbVANF6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 00:58:24 -0500
Received: from abraham.CS.Berkeley.EDU ([128.32.37.170]:13330 "EHLO
	abraham.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S261594AbVANF6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 00:58:22 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@taverner.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: short read from /dev/urandom
Date: Fri, 14 Jan 2005 05:56:41 +0000 (UTC)
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <cs7mup$hgo$1@abraham.cs.berkeley.edu>
References: <41E7509E.4030802@redhat.com>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 1105682201 17944 128.32.168.222 (14 Jan 2005 05:56:41 GMT)
X-Complaints-To: usenet@abraham.cs.berkeley.edu
NNTP-Posting-Date: Fri, 14 Jan 2005 05:56:41 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper  wrote:
>The /dev/urandom device is advertised as always returning the requested 
>number of bytes.

True.  Arguably, the solution is to fix the documentation.
Why not make /dev/urandom like every other kind of fd in the world,
and make no promises about whether a read() will always return as
many bytes as requested?  Is there any reason /dev/urandom fds special?
