Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUCIPfL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCIPfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:35:11 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14524 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262005AbUCIPfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:35:06 -0500
Date: Tue, 9 Mar 2004 16:36:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309153620.GA9012@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random> <20040309074747.GA8021@elte.hu> <20040309152121.GD8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309152121.GD8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> http://www.oracle.com/apps_benchmark/html/index.html?0325B_Report1.html

OASB is special and pushes the DB less than e.g. TPC-C does. How big was
the SGA? I bet the setup didnt have use_indirect_data_buffers=true. 
(OASB is not a full-disclosure benchmark so i have no way to check
this.) All you have proven is that workloads with a limited number of
per-inode vmas can perform well. Which completely ignores my point.

	Ingo
