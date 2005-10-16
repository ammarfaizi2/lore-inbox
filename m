Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVJPSvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVJPSvd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 14:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJPSvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 14:51:33 -0400
Received: from [82.138.41.32] ([82.138.41.32]:15547 "EHLO foo.vault.bofh.ru")
	by vger.kernel.org with ESMTP id S1751360AbVJPSvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 14:51:32 -0400
From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <87fyr2ape5.fsf@foo.vault.bofh.ru>
	<87slv23bw5.fsf@foo.vault.bofh.ru> <20051016162306.GA10410@in.ibm.com>
Date: Sun, 16 Oct 2005 22:51:12 +0400
In-Reply-To: <20051016162306.GA10410@in.ibm.com> (Dipankar Sarma's message of
	"Sun, 16 Oct 2005 21:53:07 +0530")
Message-ID: <873bn1thwf.fsf@foo.vault.bofh.ru>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> writes:

> Serge, could you please try the following experimental patch
> just to see if file counting is indeed the problem. The patch

I ran my test program with this patch applied on top of 2.6.14-rc4-git4
and it worked.
