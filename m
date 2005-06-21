Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFUIrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFUIrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVFUIra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:47:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:443 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261332AbVFUIpL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 04:45:11 -0400
Date: Tue, 21 Jun 2005 10:44:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-V0.7.49-00
Message-ID: <20050621084426.GA13094@elte.hu>
References: <20050619134400.GA19795@elte.hu> <Pine.OSF.4.05.10506210959540.28104-400000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10506210959540.28104-400000@da410.phys.au.dk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I am seeing very high latencies on 2.6.12-RT-V0.7.50-04 with a 
> modified realfeel2: maximum is 246 us. Shouldn't it be in the order of 
> 50 us?

i never got reliable results from realfeel - it should do the kind of 
careful things rtc_wakeup does to avoid false positives.

	Ingo
