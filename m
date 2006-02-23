Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWBWNtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWBWNtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 08:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWBWNtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 08:49:36 -0500
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:60821
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S1751226AbWBWNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 08:49:36 -0500
Date: Thu, 23 Feb 2006 05:49:28 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.6.15-rt17
Message-ID: <20060223134928.GA30170@gnuppy.monkey.org>
References: <20060221155548.GA30146@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221155548.GA30146@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 04:55:48PM +0100, Ingo Molnar wrote:
> another change is the reworking of the SLAB code: it now closely matches 
> the upstream SLAB code, and it should now work on NUMA systems too 
> (untested though).

SLAB you say ? What's going on with this error ?

----
mm/built-in.o: In function `drain_alien_cache':slab.c:(.text+0x1fb2c):
undefined reference to `slab_spin_unlock_irqrestore'
make: *** [.tmp_vmlinux1] Error 1
----

bill

