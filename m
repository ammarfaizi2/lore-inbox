Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWBECIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWBECIa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 21:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWBECIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 21:08:30 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9108 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932177AbWBECI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 21:08:29 -0500
Subject: Re: athlon 64 dual core tsc out of sync
From: Lee Revell <rlrevell@joe-job.com>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, s0348365@sms.ed.ac.uk, safemode@comcast.net
In-Reply-To: <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com>
References: <787b0d920602041224p660911b5mc4d639581736e96f@mail.gmail.com>
	 <1139101243.2791.78.camel@mindpipe>
	 <787b0d920602041745k65504414taaaef7f6d75b364c@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 21:08:26 -0500
Message-Id: <1139105306.2791.83.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-04 at 20:45 -0500, Albert Cahalan wrote:
> You clearly haven't been paying attention. Lots of computers vary the
> clock rate. They do this several ways. 

I certainly have been paying attention.  Most of these problems are
theoretical.  In practice the only commonly used hardware where the TSC
is so unreliable as to be unusable are dual core Athlons.

Please check the jackit-devel (this app has tight RT constraints and
used to use the TSC directly for timing so problems show up quickly)
list for details - we have seen zero bug reports due to CPU frequency
scaling issues, and TONS related to the Athlon X2.

Lee

