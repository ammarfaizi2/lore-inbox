Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTAUTND>; Tue, 21 Jan 2003 14:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267164AbTAUTNC>; Tue, 21 Jan 2003 14:13:02 -0500
Received: from bitmover.com ([192.132.92.2]:43950 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267160AbTAUTNB>;
	Tue, 21 Jan 2003 14:13:01 -0500
Date: Tue, 21 Jan 2003 11:22:04 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Schwartz <davids@webmaster.com>
Cc: dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030121192204.GA11341@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Schwartz <davids@webmaster.com>, dana.lacoste@peregrine.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2003 at 10:34:12AM -0800, David Schwartz wrote:
> 	I think I've said all I have to say on this subject, especially 
> since it doesn't affect the Linux kernel at this time. However, I 
> caution against ever allowing a situation where the preferred form 
> for making changes of any GPL'd project, preferred by the people 
> making the changes, is in any way a proprietary system.

But people don't make changes with BitKeeper, they record them.  So if
you want to push this point, you need to address 2 sections of the GPL:

    In addition, mere aggregation of another work not based on the Program
    with the Program (or with a work based on the Program) on a volume of
    a storage or distribution medium does not bring the other work under
    the scope of this License.

It's extremely easy to argue that putting a work in BK, CVS, a file
system, a tarball, whatever, is "mere aggregation".  Just because you
put a GPLed program on a Windows PC does not make the Windows NTFS
metadata GPLed.  The same is true for any storage container.

    The source code for a work means the preferred form of the work for
    making modifications to it.

People modify source code with editors.  No source management system
modifies the data, just as tar doesn't modify the data and a file system
doesn't modify the data.  So this statement doesn't make your case and
it seems to be the cornerstone of your case.

You'd have a much stronger argument if BitKeeper was an editor or an
IDE in which people made changes.  You could perhaps make the case that
Visual Slickedit (or some other commercial editor) had to come with the
source if everyone were using that editor to make changes.

I don't think you have a case.  There is a fair amount of case law which
makes it clear that no matter what a license says, it can't overstep
the law.  A good one was on slashdot in the last few days, some company
had a fairly standard "you can't benchmark this and report results"
and someone challenged it and won.  The license was telling you that
you couldn't do something that you had the legal right to do, so that
part of the license was overturned.

I think your "preferred form" argument falls into a similar camp.  It may
be that you and the rest of the world decide that your preferred form
is the BK repositories; unless enforcing that is actually legal, your
decision is meaningless, it has no legal weight.  I strongly believe that
what you are suggesting is not legal and I'm pretty sure IBM's lawyers
have looked deeply into this and they share my belief.  There is a fair
amount of case law concerning the boundaries and limits of a license.
I think if you go dig into it, you'll find that you can reach out across
clear boundaries.  Trying to apply the GPL to the metadata of a container,
be it an SCM system or a file system or an archival system, is crossing
clear boundaries and the law could care less what you prefer, a boundary
is a boundary is a boundary.

I'm not a lawyer.  I have spent a fair bit of money in legal fees looking
into this topic, however, so I'm not exactly ignorant on the topic either.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
