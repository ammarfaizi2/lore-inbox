Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWASHYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWASHYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWASHYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:24:51 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:54718 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161078AbWASHYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:24:51 -0500
Subject: Re: My vote against eepro* removal
From: Lee Revell <rlrevell@joe-job.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323320@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323320@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 02:24:48 -0500
Message-Id: <1137655489.4736.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 08:19 +0100, kus Kusche Klaus wrote:
> Last time I tested (around 2.6.12), eepro100 worked much better 
> in -rt kernels w.r.t. latencies than e100:
> 
> e100 caused a periodic latency of about 500 microseconds
> exactly every 2 seconds, no matter what the load on the interface
> was (i.e. even on an idle interface).
> 
> eepro100 did not show any latencies that long, it worked much
> smoother w.r.t. latencies.
> 
> Of course I would prefer to have e100 fixed over keeping eepro100
> around forever, but the last time I checked, it still wasn't fixed.

Please provide latency traces to illustrate the problematic code path.

It sounds like you have known about this issue for a while, were you
waiting for it to fix itself?

Lee

