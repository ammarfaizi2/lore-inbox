Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTJaQEf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 11:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTJaQEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 11:04:35 -0500
Received: from pushme.nist.gov ([129.6.16.92]:8137 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S263375AbTJaQEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 11:04:33 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
References: <20031030141519.GA10700@redhat.com>
	<9cfd6cdla4o.fsf@rogue.ncsl.nist.gov>
	<20031031152453.F4556@flint.arm.linux.org.uk>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Fri, 31 Oct 2003 11:03:52 -0500
In-Reply-To: <20031031152453.F4556@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 31 Oct 2003 15:24:53 +0000")
Message-ID: <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> On Fri, Oct 31, 2003 at 10:06:31AM -0500, Ian Soboroff wrote:
>> And APM suspend seems to have broken in -test8.  Does it work for
>> anyone?
>
> Doesn't work for me.
>
> Now, taking off my "open source co-operative hat" and placing my
> "reality" hat on, I'd suggest that anyone who finds that APM doesn't
> work to consider it a dead loss - It's an obsolete technology, and
> therefore no one is interested in it anymore.  I've reported the
> problem multiple times here and there's been very little, if any,
> reaction, so this seems to back that up.

Well, ok, but the alternatives are ACPI, which has always been spotty,
and two competing power management schemes from Patrick and Pavel,
neither of which seem to actually work yet.  Wouldn't it be nice to
have at least one working method of putting a laptop to sleep?

Once I get some free time (maybe next week, who knows) I'll try
backing out bits of the -test8 patch to see what broke.  In the
meantime, -test7 works great.

Ian


