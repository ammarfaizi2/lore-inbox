Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262202AbVBKHyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbVBKHyg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVBKHyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:54:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40937 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262202AbVBKHyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:54:33 -0500
Date: Fri, 11 Feb 2005 08:54:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Chris Wright <chrisw@osdl.org>,
       "Jack O'Quin" <jack.oquin@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Con Kolivas <kernel@kolivas.org>, rlrevell@joe-job.com
Subject: Re: 2.6.11-rc3-mm2
Message-ID: <20050211075417.GA2287@elte.hu>
References: <420C25D6.6090807@bigpond.net.au> <200502110341.j1B3fS8o017685@localhost.localdomain> <20050211065753.GE15058@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050211065753.GE15058@waste.org>
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


* Matt Mackall <mpm@selenic.com> wrote:

> Eh? Chris Wright's original rlimits patch was very straightforward
> [...]

the problem is that it didnt solve the problem (unprivileged user can
lock up the system) in any way. So after it became visible that all the
existing 'dont allow users to lock up' solutions are too invasive, we
went to recommend the solution that introduces the least architectural
problems: RT-LSM.

	Ingo
