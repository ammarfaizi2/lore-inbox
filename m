Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbUJ0Dez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUJ0Dez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUJ0Dey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:34:54 -0400
Received: from boggle.pobox.com ([208.58.1.193]:36574 "EHLO boggle.pobox.com")
	by vger.kernel.org with ESMTP id S261626AbUJ0DcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:32:18 -0400
Date: Tue, 26 Oct 2004 20:32:12 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
Message-ID: <20041027033212.GC9375@ip68-4-98-123.oc.oc.cox.net>
References: <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org> <417EC260.1010401@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417EC260.1010401@tmr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 05:32:16PM -0400, Bill Davidsen wrote:
> Linus Torvalds wrote:
[snip]
> >Which is just another reason why the name itself is not that meaningful. 
> >It can never carry the kind of information that people seem to _expect_ it 
> >to carry. 
> 
> I wasn't going to reply to this since it's your call and I've had my 
> say, but since several others have, let me throw out one more idea on 
> the off chance you like it:
> 
> Stop doing the pre's on the next version! After 2.6.10 comes 2.6.10.1 
> etc, which everyone can see are incremental changes to 2.6.10, and when 
> you really mean it, then put out 2.6.11-rc1.
> 
> Did that strike a nerve?

2.6.10.1, etc. suggests important bug fixes for 2.6.10, *not* prereleases
of 2.6.11. But... perhaps (with sufficient warning) the even/odd principle
could be applied to the third number. So, this would happen:

2.6.even   = release
2.6.even.x = release, with added bug/security fixes
2.6.odd    = first (zeroth?) -pre/-rc release
2.6.odd.x  = additional -pre/-rc releases

A more concrete example:
2.6.11-rc1, 2.6.11-rc2, 2.6.11-rc3, 2.6.11, 2.6.12-rc1, 2.6.12-rc2, 2.6.12
would become:
2.6.11,     2.6.11.1,   2.6.11.2,   2.6.12, 2.6.13,     2.6.13.1,   2.6.14

How does this sound? (It just occurred to me that this might break
scripts, but it may be worth discussing anyway.)

-Barry K. Nathan <barryn@pobox.com>

