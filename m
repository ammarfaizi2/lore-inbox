Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUGMBBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUGMBBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 21:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUGMBBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 21:01:12 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4523 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264419AbUGMBBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 21:01:08 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040712170649.6f4c0c71.akpm@osdl.org>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <200407122358.i6CNwvBD003469@localhost.localdomain>
	 <20040712170649.6f4c0c71.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089680476.10777.106.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 12 Jul 2004 21:01:16 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 20:06, Andrew Morton wrote:
> Paul Davis <paul@linuxaudiosystems.com> wrote:
> >
> > >resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
> > >fixes ended up breaking the fs in subtle ways and I eventually gave up.
> > 
> > andrew, this is really helpful. should we conclude that until some
> > announcement from reiser that they have addressed this, the reiserfs
> > should be avoided on low latency systems?
> > 
> 
> It seems that way, yes.  I do not know how common the holdoffs are in real
> life.  It would be interesting if there was a user report that switching
> from reiserfs to ext2/ext3 actually made a difference - this would tell us
> that it is indeed a real-world problem.
> 

This was not a synthetic benchmark, I would consider this a 'real-world'
problem now.  Repeating the test with ext3 would just tell you whether
it has the same problem.

If it is neccesary to get the reiserfs issue addressed, I will repeat
the test with an ext3 system in the next few days,  I would like to hear
from reiser on this before doing much more.

> Note that this info because available because someone set
> /proc/asound/*/*/xrun_debug.  We need more people doing that.
> -

This goes back to the need for ALSA documentation.  Someone needs to
write some.  This will probably require paying that person.  Hopefully
SuSe is working on this, though I suspect I would have heard something.

> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

