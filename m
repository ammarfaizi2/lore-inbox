Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbUKXJQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUKXJQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbUKXJQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:16:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:4326 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262556AbUKXJQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:16:27 -0500
Date: Wed, 24 Nov 2004 11:18:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041124101854.GA686@elte.hu>
References: <20041123133456.GA10453@elte.hu> <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Results (in short): 
> -30-9 doesn't resolved nested locking well. The expected max locking time
> in my test would be depth * 1ms - it is much higher just at a locking
> depth at two.

could you check the -30-10 kernel i just uploaded? I fixed the PI bugs
you reported (and found/fixed other ones as well).

	Ingo
