Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268015AbUHVQ2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268015AbUHVQ2z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHVQ2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:28:55 -0400
Received: from darwin.snarc.org ([81.56.210.228]:64736 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S268015AbUHVQ2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:28:50 -0400
Date: Sun, 22 Aug 2004 18:28:45 +0200
To: Albert Cahalan <albert@users.sf.net>
Cc: benh@kernel.crashing.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32 use simplified mmenonics
Message-ID: <20040822162845.GA10911@snarc.org>
References: <1093135526.5759.2513.camel@cube> <20040822094317.GA2589@snarc.org> <1093171291.5759.2544.camel@cube> <20040822144501.GA10017@snarc.org> <1093178422.2301.2674.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093178422.2301.2674.camel@cube>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 08:40:22AM -0400, Albert Cahalan wrote:
> As I said, it's a slightly better example.
> (it's also NOT what the patch was changing)

I was just commenting of the fact you prefer using bc than simplified
instructions.

> See, that's a problem. You're limiting yourself to
> just 96 of the 456 listed operations, which are only
> 1/5 of the 2304 available operations.

That was an example to show that your figures were totally silly.
I'm not limiting myself in anyway, and I could do the same stuff for
(most of) all others simplified instructions, but I think that's not the
goal of this list, neither of this thread.

> I do admit to using bne at times. The bit manipulation
> stuff is different though. It's not so cryptic in the
> raw form. The same goes for using "or" to copy a register.

> If you don't use the full bit manipulation notation
> all the time, you might forget what it can do. Then
> you'll end up using 2 instructions where one would do.

Mis-using theses instructions is not actually the point here. I agree
that a person which do that is not right.

However each person that has read some documentations about ppc assembly know
that a 'clrrwi' is a macro to a more complex instruction 'rlwinm'.

Any documentation that wouldn't mention that is just plain wrong.

> OK, that's 8. Dividing 456 by that, I still see a 57:1 ratio.
> 
> There's also that matter of the 1848 operations you can't
> access via the "simplified" instruction names.

Are you counting one operations for 'rlwinm' and one for 'rlwinm.' to have
so much (1848) operations ? or is your figures totally random ?

But anyway it seems, we could discuss the benefit or not, of using simplified
instructions the whole night. I think this is a good idea (obviously) and it
seems Benjamin thinks it too. Thoses simplified instructions are mentioned in
all officials ppc assembly documentation because they are simple and help.

But if kernel people do not want to apply this patch for the reasons you said
that's ok, but I'm not gonna discuss that for 10 hours :p

-- 
Tab
