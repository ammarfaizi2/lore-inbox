Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264380AbSIQQyI>; Tue, 17 Sep 2002 12:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264389AbSIQQyI>; Tue, 17 Sep 2002 12:54:08 -0400
Received: from ns.suse.de ([213.95.15.193]:31246 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264380AbSIQQyH>;
	Tue, 17 Sep 2002 12:54:07 -0400
To: Roberto Nibali <ratz@drugphish.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TLB flush counters gone in 2.5.35-bk?
References: <3D874DA1.20803@drugphish.ch.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Sep 2002 18:59:07 +0200
In-Reply-To: Roberto Nibali's message of "17 Sep 2002 17:44:57 +0200"
Message-ID: <p73znugtuw4.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali <ratz@drugphish.ch> writes:

> Why was that done? I'm actually about to conduct some tests where I 
> think that I need this information to check the L1 <-> L2 caching size 
> influence on kernel data structures. What is the problem with the 
> existing counters, did I miss some discussion on LKML?

You can easily get the same information from the CPU performance counters
(e.g. via oprofile) 

-Andi
