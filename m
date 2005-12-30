Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVL3H3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVL3H3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 02:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVL3H3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 02:29:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53721 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751199AbVL3H3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 02:29:53 -0500
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 02:29:48 -0500
Message-Id: <1135927789.12146.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 16:08 +0100, kus Kusche Klaus wrote:
> However, traces 1, 2, 6 and 7 are completely mysterious to me.
> Interrupts seem to be blocked for milliseconds, while nothing is going
> on on the system? Moreover, there are console-related function names
> in
> traces 6 and 7, although I've unconfigured the framebuffer console for
> these runs!
> 

It seems that either some code path really is forgetting to re-enable
interrupts, or there's a bug in the latency tracer.

Do these correspond to observed latencies?

Lee

