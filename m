Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTLOLoi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 06:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbTLOLoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 06:44:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:8912 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263527AbTLOLoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 06:44:37 -0500
Date: Mon, 15 Dec 2003 12:43:18 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: dan carpenter <error27@email.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
In-Reply-To: <200312142230.20952.error27@email.com>
Message-ID: <Pine.LNX.4.58.0312151241340.27124@earth>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312141433520.1481@home.osdl.org>
 <Pine.LNX.4.58.0312142358210.16392@earth> <200312142230.20952.error27@email.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 Dec 2003, dan carpenter wrote:

>  [<c012a65b>] exit_notify+0x2eb/0x900
>  [<c012b08f>] do_exit+0x41f/0x5c0
>  [<c012b3d7>] do_group_exit+0x107/0x190
>  [<c010aa8f>] syscall_call+0x7/0xb
> 
> There are some process that are stuck but not in zombie state that look
> like this.

do they go away if you do a kill -CONT on them?

	Ingo
