Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUCEUCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 15:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUCEUCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 15:02:00 -0500
Received: from hera.kernel.org ([63.209.29.2]:15327 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261963AbUCEUB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 15:01:59 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Fri, 5 Mar 2004 20:01:52 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2ambg$9rs$1@terminus.zytor.com>
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078516912 10109 63.209.29.3 (5 Mar 2004 20:01:52 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 5 Mar 2004 20:01:52 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp>
By author:    Miles Bader <miles@lsi.nec.co.jp>
In newsgroup: linux.dev.kernel
>
> David Eger <eger@havoc.gtf.org> writes:
> > arch/v850/kernel/as85ep1.ld	- WTF? comments in some random charset...
> 
> FWIW, the charset is EUC-JP.
> 
> Even other files in that same directory aren't consistent, e.g.,
> as85ep1.c uses ISO-2022-JP.
> 
> [My fault, but it never really registered on my important-enough-to fix
> radar (emacs autodetects them all so I never really noticed the
> discrepancy).]
> 

OK, this is definitely a good reason to go to UTF-8 across the board.

	-hpa
