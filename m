Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWGFTSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWGFTSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 15:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWGFTSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 15:18:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25821 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbWGFTSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 15:18:36 -0400
Date: Thu, 6 Jul 2006 12:18:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Michael Kerrisk <mtk-manpages@gmx.net>, mtk-lkml@gmx.net,
       rlove@rlove.org, roland@redhat.com, eggert@cs.ucla.edu,
       paire@ri.silicomp.fr, tytso@mit.edu, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net
Subject: Re: Strange Linux behaviour with blocking syscalls and stop
 signals+SIGCONT
In-Reply-To: <44AD5E5C.6070703@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0607061217320.3869@g5.osdl.org>
References: <44A92DC8.9000401@gmx.net> <44AABB31.8060605@colorfullife.com>
 <20060706092328.320300@gmx.net> <44AD599D.70803@colorfullife.com>
 <44AD5CB6.7000607@redhat.com> <44AD5E5C.6070703@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Jul 2006, Manfred Spraul wrote:
> 
> Is it necessary that the futex syscall ignores SA_RESTART?

Very possibly. That was definitely the case for "select()" long ago.

		Linus
