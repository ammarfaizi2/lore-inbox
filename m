Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286934AbSBCMGa>; Sun, 3 Feb 2002 07:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286935AbSBCMGU>; Sun, 3 Feb 2002 07:06:20 -0500
Received: from mx2.elte.hu ([157.181.151.9]:44474 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286934AbSBCMGQ>;
	Sun, 3 Feb 2002 07:06:16 -0500
Date: Sun, 3 Feb 2002 15:03:57 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Erich Focht <focht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O(1) J9 scheduler: set_cpus_allowed
In-Reply-To: <Pine.LNX.4.21.0202011633580.6004-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.33.0202031502190.10158-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 1 Feb 2002, Erich Focht wrote:

> Do I understand correctly that there is no clean way right now to
> change cpus_allowed of a task (except for current)? In the old
> scheduler it was enough to set cpus_allowed and need_resched=1...

well, there is a way, by fixing the current mechanizm. But since nothing
uses it currently it wont get much testing. I only pointed out that the
patch does not solve some of the races.

	Ingo

