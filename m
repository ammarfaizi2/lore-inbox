Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTIHF0g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 01:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbTIHF0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 01:26:36 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21176 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261969AbTIHF0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 01:26:35 -0400
Date: Sun, 7 Sep 2003 22:25:24 -0700
From: Larry McVoy <lm@bitmover.com>
To: Stephen Satchell <list@fluent2.pyramid.net>
Cc: Larry McVoy <lm@bitmover.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030908052524.GA1990@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Stephen Satchell <list@fluent2.pyramid.net>,
	Larry McVoy <lm@bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <105370000.1062622139@flay> <20030903212119.GX4306@holomorphy.com> <115070000.1062624541@flay> <20030903215135.GY4306@holomorphy.com> <116940000.1062625566@flay> <20030904010653.GD5227@work.bitmover.com> <m11xusnvqc.fsf@ebiederm.dsl.xmission.com> <20030907230729.GA19380@work.bitmover.com> <m1wuckma9z.fsf@ebiederm.dsl.xmission.com> <5.2.1.1.0.20030907214214.01c25ac8@fluent2.pyramid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.0.20030907214214.01c25ac8@fluent2.pyramid.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 09:47:58PM -0700, Stephen Satchell wrote:
> At 05:57 PM 9/7/2003 -0700, Larry McVoy wrote:
> >That's not "a machine" that's ~1150 machines on a network.  This business
> >of describing a bunch of boxes on a network as "a machine" is nonsense.
> 
> Then you haven't been keeping up with Open-source projects, or the 
> literature.  

Err, I'm in that literature, dig a little, you'll find me.  I'm quite
familiar with clustering technology.  While it is great that people are
wiring up lots of machines and running MPI or whatever on them, they've
been doing that for decades.  It's only a recent thing that they started
calling that "a machine".  That's marketing, and it's fine marketing,
but a bunch of machines, a network, and a library does not a machine make.
Not to me it doesn't.  I want to be able to exec a proces and have it land
anywhere on the "machine", any CPU, I want controlling tty semantics,
if I have 2300 processes in one process group then when I hit ^Z they
had all better stop.  Etc.

A collection of machines that work together is called a network of 
machines, it's not one machine, it's a bunch of them.  There's nothing
wrong with getting a lot of use out of a pile of networked machines,
it's a great thing.  But it's no more a machine than the internet is
a machine.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
