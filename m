Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUJAWaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUJAWaD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUJAW1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:27:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:52114 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266775AbUJAWTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:19:40 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: "Jack O'Quin" <joq@io.com>, Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
In-Reply-To: <20041001142259.I1924@build.pdx.osdl.net>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1096669179.27818.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 18:19:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 17:23, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > On Fri, 2004-10-01 at 00:05, Jack O'Quin wrote:
> > > The ulimit approach is way too cumbersome.
> > 
> > Agreed.  The whole point of getting realtime-lsm in the kernel is to
> > make it _easier_ to get a linux audio (or other realtime system) up and
> > running.
> 
> It's nice to have something that's easy to use, but that's not a great
> justification for addition to the kernel.  Esp. when there's a
> functional userspace solution.
> 

OK, poor choice of words.  Correctness of course comes before ease of
use.  I believe the realtime-lsm module satisfies both requirements.

> > The ulimit approach would probably be acceptable
> > if it subsumed all the functionality of the realtime-lsm module.
> 
> Hrm, I guess we'll have to agree to disagree.  The whole point of the
> mlock rlimits code is to enable this policy to be pushed to userspace.
> A generic method of enabling capabilities is the best way to go, long
> term.  Any interest in pursuing that?

I did not mean to imply that I disagree with the realtime-lsm approach. 
Obviously some kernel support is required, and realtime-lsm seems to
solve the problem with the minimum possible change to the kernel.  And
above all it is a proven working solution that has been field tested for
months by many, many users.

Lee

