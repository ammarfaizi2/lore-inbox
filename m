Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUK0AUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUK0AUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 19:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbUKZX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:58:04 -0500
Received: from zeus.kernel.org ([204.152.189.113]:9413 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262454AbUKZTle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:41:34 -0500
Date: Thu, 25 Nov 2004 17:08:48 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
In-Reply-To: <20041125165829.GA24121@elte.hu>
Message-Id: <Pine.OSF.4.05.10411251706290.12827-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Nov 2004, Ingo Molnar wrote:

> [...] 
> there's one thing i noticed, now that the blocker device is in the
> kernel, you have to be really careful to compile the userspace loop()
> code via the same gcc flags as the kernel did. Minor differences in
> compiler options can skew the timing calibration.
> 
> but any such bug should at most cause a linear deviation via a constant
> factor multiplication, while the data shows a systematic nonlinear
> transformation.
> 
-g -Wall -O2 was on in userspace.

> [...] 
> yeah, i agree that this has to be further investigated. What type of box
> did you test it on - UP or SMP? (SMP scheduling of RT tasks only got
> fully correct in the very latest -31-7 kernel.)
> 
UP, PIII 697.143 Mhz

> 	Ingo
> 

Esben

