Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271246AbUJVL4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271246AbUJVL4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271244AbUJVL4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:56:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58069 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S271240AbUJVL4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:56:17 -0400
Date: Fri, 22 Oct 2004 13:57:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Gunther Persoons <gunther_persoons@spymac.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
Message-ID: <20041022115734.GA1790@elte.hu>
References: <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <4177FAB0.6090406@spymac.com> <20041021164018.GA11560@elte.hu> <16759.63466.507400.649099@thebsh.namesys.com> <20041022102210.GA21734@elte.hu> <16760.62448.307737.588876@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16760.62448.307737.588876@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nikita Danilov <nikita@clusterfs.com> wrote:

>  > condition variables are fine if you 1) already know them from userspace
>  > and 2) want to use a single locking abstraction for everything. It is
>  > thus also a kitchen-sink primitive that is inevitably slow and complex.
>  > I still have to see a locking problem where condvars are the
>  > cleanest/simplest answer, and i've yet to see a locking problem where
>  > condvars are not the slowest answer ;)
> 
> A kernel daemon that waits for some work to do is an example.

what type of work - could you be a bit more specific?

	Ingo
