Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWAQXHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWAQXHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 18:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWAQXHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 18:07:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932488AbWAQXHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 18:07:31 -0500
Date: Tue, 17 Jan 2006 15:06:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: bug tracking
Message-Id: <20060117150612.345571ef.akpm@osdl.org>
In-Reply-To: <20060117224433.GF19398@stusta.de>
References: <OFA777C944.9337E52B-ONC12570C1.0039A0E1-C12570C9.004D661A@avm.de>
	<20060117224433.GF19398@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> is your problem still present in kernel 2.6.16-rc1?
>

What I've been doing for email bug reports is

a) Respond if I can, forward to maintainer, save them away

b) Wait a while (weeks to months)

c) Privately email the reporter, saying "if this bug is still present in
   2.6.15, please raise a report at bugzilla.kernel.org"


I've sent 100-200 of these emails in the past few days.  Of the people
who've responded, the great majority of these bugs were actually fixed, which
is nice.

My overall intent here is: if the bug isn't quickly resolved, get it moved
from email into bugzilla, where we can sanely keep track of its status.

For long-term bug tracking, I want to only track bugzilla-based bugs.  It
just gets too insane trying to follow the status of email-based reports.


What I'm doing locally is tracking all the bugzilla bugs which I think need
addressing, categorised by subsystem.  Go through them periodically, toss
out the ones which have been fixed.  I have a few hundred reports to go
through and I plan on getting nicely-collated per-subsystem reports out to
the mailing lists soon - probably next week.

I'm not tracking acpi at all - the acpi guys are doing that well and there
are too damn many of them ;)

What I'm not bothering to do is to close off or to reject fixed or
uninteresting bug reports.  I just silently ignore them.  Which means that
a bugzilla-based query will toss up a lot of noise, which is sad.  And I'm
not ensuring that all bugs are categorised as well as they could be - I do
that locally.  It's be nice to do these things, but it's dull and
time-consuming.

I do expect and hope that subsystem maintainers and developers will put
bugs into appropriate states as they work on them - most people are good
about this, but it varies a lot.


