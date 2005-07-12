Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVGLUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVGLUHY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262484AbVGLUHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 16:07:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50853 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262360AbVGLUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 16:05:25 -0400
Subject: Re: realtime-preempt + reiser4?
From: Lee Revell <rlrevell@joe-job.com>
To: Keenan Pepper <keenanpepper@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42D4201A.9050303@gmail.com>
References: <42D4201A.9050303@gmail.com>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 16:05:23 -0400
Message-Id: <1121198723.10580.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 15:55 -0400, Keenan Pepper wrote:
> Ingo Molnar's realtime-preempt patches used to be based on the -mm 
> kernels, but now they appear to be based on the mainline kernels, so 
> they don't support reiser4 (at least until reiser4 is merged into 
> mainline, which is looking uncertain as I understand it).

It's not uncertain, the reiser4 people just have to address the issues
that were raised on LKML before it will be merged, just like everyone
else.

> Is realtime-preempt-2.6.10-mm1-V0.7.34-01 the most recent 
> realtime-preempt kernel to support reiser4?
> How is the latency of the reiser4 code itself?

No one ever posted any numbers (to LKML anyway) so we don't know.

Maybe you could apply the broken out reiser4 patches from -mm and the
realtime preempt patches.  Testing with PREEMPT_DESKTOP and latency
tracing enabled will tell you whether reiser4 has any latency hot spots.

Lee

