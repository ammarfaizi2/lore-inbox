Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWHLHIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWHLHIG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 03:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWHLHIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 03:08:06 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:22144 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751330AbWHLHIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 03:08:04 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Kasper Sandberg <lkml@metanurb.dk>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.33 released
Date: Sat, 12 Aug 2006 17:08:00 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <94vqd2h9onenqiu03ujk4u3jln36a2b9st@4ax.com>
References: <200608110418.k7B4IqDn017355@hera.kernel.org> <1155318180.23933.7.camel@localhost> <20060811190923.GJ8776@1wt.eu> <e8eqd2ho9a92hiqohjfmkhsbohl5beabvf@4ax.com> <20060812040441.GC6666@1wt.eu>
In-Reply-To: <20060812040441.GC6666@1wt.eu>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2006 06:04:41 +0200, Willy Tarreau <w@1wt.eu> wrote:

>On Sat, Aug 12, 2006 at 12:18:23PM +1000, Grant Coady wrote:
>> On Fri, 11 Aug 2006 21:09:23 +0200, Willy Tarreau <w@1wt.eu> wrote:
>> 
>> >Hello,
>> >
>> >On Fri, Aug 11, 2006 at 07:43:00PM +0200, Kasper Sandberg wrote:
>> >> On Fri, 2006-08-11 at 04:18 +0000, Marcelo Tosatti wrote:
>> >> > final:
>> >> > 
>> >> > - 2.4.33-rc3 was released as 2.4.33 with no changes.
>> >> I have one suggestion for the 2.4 tree, next time a few changes is
>> >> introduced, they could be put as a bugfix release, as with the 2.6
>> >> branch now, so that it doesent end up taking years for a new 2.4
>> >> release, and instead a point release(if any such thing happens at all)
>> >
>> >This has already the case with the hotfix tree since 18 months or so. A
>> >hotfix release is issued when there are important fixes. Anyway, I was
>> >thinking about releasing pre-releases more often. Also, you might have
>> >noticed that the slowdown is more important during -rc for obvious reasons.
>> 
>> >To solve this problem, I intend to maintain a 'next' branch in the tree
>> >which will contain the fixes that can wait for next version. It should
>> >help us batch the fixes and reduce the latency between important fixes
>> >and the associated release.
>> 
>> Perhaps time to follow the 2.6.nn-stable naming scheme?  Since you're in 
>> the driver's seat now?  This may be less confusing to 2.4 series users.
>
>The difference is that I provide hotfixes for older versions too, and if
>you remember, initially all versions got a different suffix, which was

Yup, remembered that after I posted, 'tis only a name, after all

>really confusing. Now at least they all get the same one. Or perhaps I
>should use the 4 digit for the last version and something derived from
>it for older versions, I'll have to think about it.

Perhaps a bad idea after all, current users know where to get hotfix.

>> You'd have an idea how popular your hotfix project has been from your 
>> server download stats?  I've mostly run hotfix-latest on firewall 24/7 
>> since you started the project.
>
>It varies depending on the fixes. For instance, on hf32.6, I got 737
>downloads: 69% for the latest version (2.4.32), 10% for 2.4.29, 8% for
>2.4.30, 7% for 2.4.31, and 6% for 2.4.28.

> But it's hard to tell how
>many systems run those patches, because some people might download
>them just for curiosity, and others download them once an apply them
>on a hundred of machines.

Only another half dozen here, but yes some unknown multiplier may 
swamp the curious.

> From the feedback I got, people often use
>the latest hotfix as the first patch for their own kernels (and I do
>the same) so that they know they're up to date, and can add the
>features they need.

I try convince people to do that ;)  
>
>Also, many people know that 2.4 is stable enough that most often,
>any pre-release can be used as a hotfix.

Yup.

Grant.
