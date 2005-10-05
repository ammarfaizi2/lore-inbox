Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVJETj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVJETj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 15:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVJETj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 15:39:28 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:36868 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1030338AbVJETj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 15:39:27 -0400
Message-ID: <43442C14.2040206@tmr.com>
Date: Wed, 05 Oct 2005 15:40:04 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: The price of SELinux (CPU)
References: <434204F8.2030209@comcast.net> <200510041539.j94FdJmO028772@turing-police.cc.vt.edu>            <4342C9F1.2000005@comcast.net> <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>
In-Reply-To: <200510041943.j94Jhj4C007314@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 04 Oct 2005 14:29:05 EDT, John Richard Moser said:
> 
> 
>>Aside from this, viruses and spyware and worms can now run rampant and
>>do what they want to his system, and other users' idiotic actions on a
>>multi-user system affect him.  This is more user friendly?  No, I think
>>it's going in the opposite direction. . . .
> 
> 
> Virus writers are users too, you know.  :)
> 
> And the other users are users as well - what if the other user's "idiotic
> action" is to nuke your 500Mbyte archive of alt.binaries.pictures.llama.sex
> that's taking up the disk space that is keeping him from running the payroll
> software?  In your world, rather than him being able to fix the problem, he has
> to go find a sysadmin with the root password to fix it, causing delays and
> being less friendly....
> 
> You seem to be intentionally trying to miss the basic point, which is that
> any additional security ends up trading off against other things.
> 
> Non-execute stack is a Good Thing security-wise - but it breaks some code,
> forcing upgrades and/or having to track down binaries and flag them as
> "don't enforce NX stack".  And then those binaries are still vulnerable....
> 
> SELinux is, in general, also a Good Thing.  However, the fact that the policy
> restricts what stuff can happen in the security context associated with
> mail delivery (after all, you *don't* want arbitrary binaries running then, right?)
> did some serious damage to the way I use procmail, which in some cases ended
> up running other binaries.  OK, so my .procmailrc *is* a 600-line monster that
> does a lot of odd stuff - the point was that I had to add even *more* contortions
> to the way it works, which is even less user-friendly....
> 
> 
Doesn't everyone have executables in their .procmailrc? Mine starts with 
a filter which may add one line to the mail header, quantifying exactly 
how badly it sucks. That's then used to take preemptive action against 
spam and other stuff I don't wnat or need to see.

That's a lot to give up.
