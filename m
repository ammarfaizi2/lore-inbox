Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUJAWef@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUJAWef (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266643AbUJAWag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:30:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:40586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266663AbUJAW2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 18:28:00 -0400
Date: Fri, 1 Oct 2004 15:27:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, "Jack O'Quin" <joq@io.com>,
       Jody McIntyre <realtime-lsm@modernduck.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20041001152746.L1924@build.pdx.osdl.net>
References: <1094967978.1306.401.camel@krustophenia.net> <20040920202349.GI4273@conscoop.ottawa.on.ca> <20040930211408.GE4273@conscoop.ottawa.on.ca> <1096581213.24868.19.camel@krustophenia.net> <87pt43clzh.fsf@sulphur.joq.us> <20040930182053.B1973@build.pdx.osdl.net> <87k6ubcccl.fsf@sulphur.joq.us> <1096663225.27818.12.camel@krustophenia.net> <20041001142259.I1924@build.pdx.osdl.net> <1096669179.27818.29.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1096669179.27818.29.camel@krustophenia.net>; from rlrevell@joe-job.com on Fri, Oct 01, 2004 at 06:19:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell (rlrevell@joe-job.com) wrote:
> On Fri, 2004-10-01 at 17:23, Chris Wright wrote:
> > It's nice to have something that's easy to use, but that's not a great
> > justification for addition to the kernel.  Esp. when there's a
> > functional userspace solution.
> 
> OK, poor choice of words.  Correctness of course comes before ease of
> use.  I believe the realtime-lsm module satisfies both requirements.

I agree with that.  That's not my objection.  It's about pushing code
(albeit it's small and non-invasive) into the kernel that can be done in
userspace, that's all.

> > > The ulimit approach would probably be acceptable
> > > if it subsumed all the functionality of the realtime-lsm module.
> > 
> > Hrm, I guess we'll have to agree to disagree.  The whole point of the
> > mlock rlimits code is to enable this policy to be pushed to userspace.
> > A generic method of enabling capabilities is the best way to go, long
> > term.  Any interest in pursuing that?
> 
> I did not mean to imply that I disagree with the realtime-lsm approach. 
> Obviously some kernel support is required, and realtime-lsm seems to
> solve the problem with the minimum possible change to the kernel.  And
> above all it is a proven working solution that has been field tested for
> months by many, many users.

Clearly it's useful for the audio folks.  Whether it's the right thing
to go into the kernel is all that's in question here.  Do we agree it's
a stopgap measure making up for lack of a better general solution?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
