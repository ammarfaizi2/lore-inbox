Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVEZWWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVEZWWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVEZWWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 18:22:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46485 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261833AbVEZWWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 18:22:24 -0400
Date: Thu, 26 May 2005 15:22:17 -0700
Message-Id: <200505262222.j4QMMHWe010741@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: waitid() fails with EINVAL for SA_RESTART signals
In-Reply-To: Michael Kerrisk's message of  Wednesday, 18 May 2005 10:20:47 +0200 <24601.1116404447@www71.gmx.net>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other machines are subject to the same risk and should have a
prevent_tail_call definition too.  The asm-i386/linkage.h version probably
works fine for every machine.  It might as well be generic, I'd say.
