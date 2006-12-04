Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758599AbWLDCBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599AbWLDCBq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 21:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758768AbWLDCBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 21:01:46 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:64650
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1758599AbWLDCBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 21:01:45 -0500
Date: Sun, 3 Dec 2006 18:01:35 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: [PATCH 3/4] lock stat (rt/rtmutex.c mods) for 2.6.19-rt1
Message-ID: <20061204020135.GE28519@gnuppy.monkey.org>
References: <20061204015438.GB28519@gnuppy.monkey.org> <20061204015653.GC28519@gnuppy.monkey.org> <20061204020009.GD28519@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204020009.GD28519@gnuppy.monkey.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2006 at 06:00:09PM -0800, Bill Huey wrote:
> Rudimentary annotations to the lock initializers to avoid the binary
> tree search before attachment. For things like inodes that are created
> and destroyed constantly this might be useful to get around some
> overhead.
> 
> Sorry, about the patch numbering order. I think I screwed up on it.

I also screwed up on the title for the email contents. Sorry about that.

bill

