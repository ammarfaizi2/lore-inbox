Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWHVXWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWHVXWE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHVXWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:22:04 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:10448
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932192AbWHVXWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:22:03 -0400
Date: Tue, 22 Aug 2006 16:21:47 -0700
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Message-ID: <20060822232147.GB8991@gnuppy.monkey.org>
References: <e6babb600608110800g379ed2c3gd0dbed706d50622c@mail.gmail.com> <20060811211857.GA32185@gnuppy.monkey.org> <20060811221054.GA32459@gnuppy.monkey.org> <e6babb600608141056j4410380fr15348430738c91d8@mail.gmail.com> <20060814234423.GA31230@gnuppy.monkey.org> <e6babb600608151053u6b902b80k9e3b399fe34ee10f@mail.gmail.com> <20060818115934.GA29919@gnuppy.monkey.org> <e6babb600608211721g739c5518sa14427d1e9f2334@mail.gmail.com> <20060822013722.GA628@gnuppy.monkey.org> <20060822232051.GA8991@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822232051.GA8991@gnuppy.monkey.org>
User-Agent: Mutt/1.5.11+cvs20060403
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2006 at 04:20:51PM -0700, Bill Huey wrote:
> On Mon, Aug 21, 2006 at 06:37:22PM -0700, Bill Huey wrote:
> > I'll come up with a patch tomorrow to try and get a clean stack trace. I've
> > made some change to the bug dump output to make it more preemption aware,
> > but, as you can, some tweeking is needed.
> 
> I turned off the tracing in the latency tracking stuff and a relatively
> small patch is here against -rt8:

At __WARN_ON()... I meant.

bill


