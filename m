Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271731AbTG2NdG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271733AbTG2NdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:33:06 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:36503 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S271731AbTG2NdC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:33:02 -0400
Date: Tue, 29 Jul 2003 16:32:54 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: John Bradford <john@grabjohn.com>
Cc: helgehaf@aitel.hist.no, jamie@shareable.org, linux-kernel@vger.kernel.org,
       tosh@is.s.u-tokyo.ac.jp
Subject: Re: The well-factored 386
Message-ID: <20030729133254.GT150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	John Bradford <john@grabjohn.com>, helgehaf@aitel.hist.no,
	jamie@shareable.org, linux-kernel@vger.kernel.org,
	tosh@is.s.u-tokyo.ac.jp
References: <200307291259.h6TCxfC3000230@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307291259.h6TCxfC3000230@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 01:59:41PM +0100, you [John Bradford] wrote:
> > > I didn't realise he was talking about an x86 emulator.  I thought he
> > > was analyzing real hardware.
> > > 
> > > The one thing that made it on-topic for me was his quiet suggestion
> > > that "forreal" mode interrupts are faster, and that it might, perhaps,
> > > be possible to modify a Linux kernel to run in that mode - to take
> > > advantage of the faster interrupts.
> >
> > That would have to be a kernel for very special use.  The "forreal"
> > mode has protection turned off.  As far as I know, that
> > means any user process can take over the cpu as if
> > it was running in kernel mode.
> >
> > Perhaps useful for some embedded use with only a couple well-tested
> > processes running.  Still, a programming error could overwrite
> > kernel memory instead of segfaulting.
> 
> Anything that's single user and non-networked isn't beyond the realms
> of feasability - it would be useful for a games console, or high
> performance graphics work.
> 
> It would be an interesting project, but what concerns me is how well
> implemented these non-standard modes actually are.  It's possible that
> there are processors out there that don't work reliably with them, or
> don't implement them at all.

Have you looked at Kernel Mode Linux?

  http://web.yl.is.s.u-tokyo.ac.jp/~tosh/kml/

I don't think it uses "forreal" mode, but it allows running selected user
processes in kernel mode thus getting rid of system call overhead.

[Note to Toshiyuki Maeda: the complete thread is at
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=expl.8vH.27%40gated-at.bofh.it&rnum=1&prev=/groups%3Fq%3DThe%2Bwell-factored%2B386%26num%3D50%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26sa%3DN%26tab%3Dwg
in case you want to catch some context. The "forreal" idea is mentioned in
the first mail of the thread.]


-- v --

v@iki.fi
