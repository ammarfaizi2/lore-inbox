Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVCOO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVCOO7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 09:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVCOO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 09:59:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64556
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S261314AbVCOO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 09:59:05 -0500
Date: Tue, 15 Mar 2005 15:59:03 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@cpushare.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050315145903.GS7699@opteron.random>
References: <20050225211453.GC3311@stusta.de> <20050226013137.GO20715@opteron.random> <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315144428.GA13318@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315144428.GA13318@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 03:44:28PM +0100, Ingo Molnar wrote:
> let me put it another way: this is a security hole. seccomp is now a way
> to evade the auditing of read/write syscalls done to an opened file. 
> Please fix this.

This is not true, the auditing of read/write will work fine on the
seccomp task too. I guess you overlooked something in the code.
