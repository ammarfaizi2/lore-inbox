Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBPJnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBPJnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 04:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWBPJnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 04:43:43 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:35984
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751356AbWBPJnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 04:43:42 -0500
Date: Thu, 16 Feb 2006 01:37:12 -0800
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt16: possible sound-related side-effect
Message-ID: <20060216093712.GA28919@gnuppy.monkey.org>
References: <200602152339.k1FNdVIO021090@auster.physics.adelaide.edu.au> <Pine.LNX.4.58.0602160245150.7272@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602160245150.7272@gandalf.stny.rr.com>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 02:55:17AM -0500, Steven Rostedt wrote:
> Yeah, could you just add that dump_stack to see who is calling this.  Then
> we can look into that.

I'm also getting a funny x86_64 crash on boot with what looks like the
slab.c changes and the cache_grow() function. Tracking it down has been
rather odd in the it's complaining about a fault deferencing a bogus
value on a up_mutex. I'll see what I can do in the next day or so.

bill

