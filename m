Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271148AbTHCLgt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTHCLgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:36:48 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:34439
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S271148AbTHCLgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:36:47 -0400
Message-ID: <1059910601.3f2cf3c908043@kolivas.org>
Date: Sun,  3 Aug 2003 21:36:41 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O12.2int for interactivity
References: <Pine.LNX.4.44.0308031307070.5475-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0308031307070.5475-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ingo Molnar <mingo@elte.hu>:

> 
> On Sun, 3 Aug 2003, Con Kolivas wrote:
> 
> > Reverted Ingo's EXPIRED_STARVING definition; it was making interactive
> > tasks expire faster as cpu load increased.
> 
> hm, that bit was needed for fairness, otherwise 'interactive' tasks can
> monopolize the CPU. [ Have you tried lots of copies of thud.c (and
> Davide's irman2 with the most evil settings), do they still produce no
> starvation with this bit restored to the original logic? ]

Ooh hang on I've not tried lots of copies of thud.c at once. Can't try for a 
little while though.

Con
