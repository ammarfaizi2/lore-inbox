Return-Path: <linux-kernel-owner+w=401wt.eu-S1030311AbWL3TcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWL3TcQ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWL3TcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:32:16 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59455
	"EHLO gnuppy.monkey.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030306AbWL3TcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:32:16 -0500
Date: Sat, 30 Dec 2006 11:32:07 -0800
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Chen, Tim C" <tim.c.chen@intel.com>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Message-ID: <20061230193207.GA17882@gnuppy.monkey.org>
References: <9D2C22909C6E774EBFB8B5583AE5291C019998CA@fmsmsx414.amr.corp.intel.com> <20061229232618.GA11239@gnuppy.monkey.org> <20061230111940.GA8412@elte.hu> <1167490569.14081.71.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167490569.14081.71.camel@imap.mvista.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2006 at 06:56:08AM -0800, Daniel Walker wrote:
> On Sat, 2006-12-30 at 12:19 +0100, Ingo Molnar wrote:
> 
> > 
> >  - Documentation/CodingStyle compliance - the code is not ugly per se
> >    but still looks a bit 'alien' - please try to make it look Linuxish,
> >    if i apply this we'll probably stick with it forever. This is the
> >    major reason i havent applied it yet.
> 
> I did some cleanup while reviewing the patch, nothing very exciting but
> it's an attempt to bring it more into the "Linuxish" scope .. I didn't
> compile it so be warned.
> 
> There lots of ifdef'd code under CONFIG_LOCK_STAT inside rtmutex.c I
> suspect it would be a benefit to move that all into a header and ifdef
> only in the header .

Ingo and Daniel,

I'll try and make it more Linuxish. It's one of the reasons why I posted
it since I knew it would need some kind of help in that arena and I've
been in need of feedback regarding it. Originally, I picked a style that
made what I was doing extremely obvious and clear to facilitate
development which is the rationale behind it.

I'll make those changes and we can progressively pass it back and forth
to see if this passes.

bill

