Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269259AbUJKVQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269259AbUJKVQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 17:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJKVQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 17:16:10 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:20669 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269259AbUJKVQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 17:16:07 -0400
Date: Mon, 11 Oct 2004 14:16:05 -0700
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-ID: <20041011211605.GD3316@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041010211507.GB3316@triplehelix.org> <200410112055.i9BKt5LI031359@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410112055.i9BKt5LI031359@magilla.sf.frob.com>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040722i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 01:55:05PM -0700, Roland McGrath wrote:
> That is a clearly bogus argument.  (In fact it looks like a stack address,
> a common thing to be found in uninitialized variables.)  Unless you have
> some reason to suspect that this is not the argument actually passed by
> make, then you should look at make and see why it passed the bogus
> argument.  So far, I still don't see a direct suggestion of a kernel bug
> here.  

All I know is that this doesn't happen in kernels where the waitid patch
was not applied. It has *NEVER* happened until now.

Possibly it was strace catching the wrong end of whatever make was doing
when it started ptracing it.

Could it be glibc's problem.

-- 
Joshua Kwan
