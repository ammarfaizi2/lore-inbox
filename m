Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbTBWJ2v>; Sun, 23 Feb 2003 04:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbTBWJ2l>; Sun, 23 Feb 2003 04:28:41 -0500
Received: from holomorphy.com ([66.224.33.161]:64939 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268093AbTBWJ2P>;
	Sun, 23 Feb 2003 04:28:15 -0500
Date: Sun, 23 Feb 2003 01:37:26 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223093726.GE27135@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay> <20030222024721.GA1489@work.bitmover.com> <14450000.1045888349@[10.10.2.4]> <20030222050514.GA3148@work.bitmover.com> <19870000.1045895965@[10.10.2.4]> <20030222083810.GA4170@gtf.org> <20030222221820.GI10401@holomorphy.com> <20030222201724.E5536@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222201724.E5536@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 02:18:20PM -0800, William Lee Irwin III wrote:
>> I'm not sure what's so nice about x86-64; another opcode prefix
>> controlled extension atop the festering pile of existing x86 crud

On Sat, Feb 22, 2003 at 08:17:24PM -0500, Benjamin LaHaise wrote:
> What's nice about x86-64 is that it runs existing 32 bit apps fast and 
> doesn't suffer from the blisteringly small caches that were part of your 
> rant.  Plus, x86-64 binaries are not horrifically bloated like ia64.  
> Not to mention that the amount of reengineering in compilers like 
> gcc required to get decent performance out of it is actually sane.

Rant? It was just a catalogue of other things that are nasty. The
point was that PAE's not special, it's one of a very long list of
very ugly uglinesses, and my list wasn't anywhere near exhaustive.
But yes, more cache is good. Unfortunately the amount of baggage from
32-bit x86 stuff still puts a good chunk of systems programming into
the old bring your own barfbag territory.


On Sat, Feb 22, 2003 at 02:18:20PM -0800, William Lee Irwin III wrote:
>> sounds every bit as bad any other attempt to prolong x86. Some of
>> the system device -level cleanups like the HPET look nice, though.

On Sat, Feb 22, 2003 at 08:17:24PM -0500, Benjamin LaHaise wrote:
> HPET is part of one of the PCYY specs and even available on 32 bit x86, 
> there are just not that many bug free implements yet.  Since x86-64 made 
> it part of the base platform and is testing it from launch, they actually 
> have a chance at being debugged in the mass market versions.

Well, it beats the heck out of the TSC and the PIT, and x86-64 is
apparently supposed to have it "for real".

I'm not excited at all about another opcode prefix and pagetable format.


-- wli
