Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWCZVaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWCZVaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWCZVaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:30:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:65414 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932131AbWCZVaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:30:20 -0500
Date: Sun, 26 Mar 2006 23:27:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: Are ALL_TASKS_PI on in 2.6.16-rt7?
Message-ID: <20060326212738.GA32562@elte.hu>
References: <Pine.LNX.4.44L0.0603262205320.8060-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603262205320.8060-100000@lifa03.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> It just looks like also normal, non-rt tasks are boosting.

correct. We'd like to make sure the PI code is correct - and for 
PI-futex it makes sense anyway.

	Ingo
