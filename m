Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbULNVnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbULNVnQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 16:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULNVnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 16:43:13 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57267 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261672AbULNVkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 16:40:39 -0500
Subject: Re: RCU question
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20041212121546.GM16322@dualathlon.random>
References: <41BA59F6.5010309@mvista.com>
	 <Pine.LNX.4.61.0412101943260.1101@montezuma.fsmlabs.com>
	 <41BA698E.8000603@mvista.com>
	 <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
	 <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com>
	 <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
	 <41BC0854.4010503@colorfullife.com>
	 <20041212093714.GL16322@dualathlon.random>
	 <41BC1BF9.70701@colorfullife.com>
	 <20041212121546.GM16322@dualathlon.random>
Content-Type: text/plain
Date: Tue, 14 Dec 2004 16:40:37 -0500
Message-Id: <1103060437.14699.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-12 at 13:15 +0100, Andrea Arcangeli wrote:
> Overall this is a very minor issue (unless HZ is 0), it would only
> introduce a 1/HZ latency to the irq that get posted while the nmi
> handler is running, and the nmi handlers never runs in production.

Ingo, couldn't this account for some of the inexplicable outliers some
people were seeing in latency tests?

Lee

