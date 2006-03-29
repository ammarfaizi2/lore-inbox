Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWC2GQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWC2GQN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWC2GQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:16:12 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22921 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751088AbWC2GQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:16:11 -0500
Subject: Re: interactive task starvation
From: Lee Revell <rlrevell@joe-job.com>
To: ray-gmail@madrabbit.org
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <2c0942db0603282156x468f4246nae414b2a853668dc@mail.gmail.com>
References: <1142592375.7895.43.camel@homer>
	 <200603220119.50331.kernel@kolivas.org> <1142951339.7807.99.camel@homer>
	 <200603220130.34424.kernel@kolivas.org> <20060321143240.GA310@elte.hu>
	 <20060321144410.GE26171@w.ods.org> <20060321145202.GA3268@elte.hu>
	 <1143601277.3330.2.camel@mindpipe>
	 <2c0942db0603282156x468f4246nae414b2a853668dc@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 01:16:07 -0500
Message-Id: <1143612969.3330.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 21:56 -0800, Ray Lee wrote:
> Do any of the above WAGs match what you see? If so, then perhaps it's
> random just due to the order in which the tasks get initially
> scheduled (dmesg vs ssh, or dmesg vs xterm vs X -- er, though I guess
> in that latter case there's really <thinks> three separate timings
> that you'd get back, as the triple set of tasks could be in one of six
> orderings, one fast, one slow, and four equally mixed between the
> two).
> 

Possibly - *very* rarely, like 1 out of 50 or 100 times, it falls
somewhere in the middle.

Lee

