Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUJAWfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUJAWfw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJAWfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:35:34 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62867 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266749AbUJAWc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:32:59 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: "Jack O'Quin" <joq@io.com>, Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
In-Reply-To: <20041001152746.L1924@build.pdx.osdl.net>
References: <1094967978.1306.401.camel@krustophenia.net>
	 <20040920202349.GI4273@conscoop.ottawa.on.ca>
	 <20040930211408.GE4273@conscoop.ottawa.on.ca>
	 <1096581213.24868.19.camel@krustophenia.net>
	 <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net>
	 <87k6ubcccl.fsf@sulphur.joq.us>
	 <1096663225.27818.12.camel@krustophenia.net>
	 <20041001142259.I1924@build.pdx.osdl.net>
	 <1096669179.27818.29.camel@krustophenia.net>
	 <20041001152746.L1924@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1096669977.27818.35.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 01 Oct 2004 18:32:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-01 at 18:27, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > On Fri, 2004-10-01 at 17:23, Chris Wright wrote:
> > > It's nice to have something that's easy to use, but that's not a great
> > > justification for addition to the kernel.  Esp. when there's a
> > > functional userspace solution.
> > 
> > OK, poor choice of words.  Correctness of course comes before ease of
> > use.  I believe the realtime-lsm module satisfies both requirements.
> 
> I agree with that.  That's not my objection.  It's about pushing code
> (albeit it's small and non-invasive) into the kernel that can be done in
> userspace, that's all.
> 

How do you envision this working?  I am sure it's possible, I think I am
just not seeing how it would be different in practice.

> > > > The ulimit approach would probably be acceptable
> > > > if it subsumed all the functionality of the realtime-lsm module.
> > > 
> > > Hrm, I guess we'll have to agree to disagree.  The whole point of the
> > > mlock rlimits code is to enable this policy to be pushed to userspace.
> > > A generic method of enabling capabilities is the best way to go, long
> > > term.  Any interest in pursuing that?
> > 
> > I did not mean to imply that I disagree with the realtime-lsm approach. 
> > Obviously some kernel support is required, and realtime-lsm seems to
> > solve the problem with the minimum possible change to the kernel.  And
> > above all it is a proven working solution that has been field tested for
> > months by many, many users.
> 
> Clearly it's useful for the audio folks.  Whether it's the right thing
> to go into the kernel is all that's in question here.  Do we agree it's
> a stopgap measure making up for lack of a better general solution?
> 

See above, no argument here from me.

Lee

