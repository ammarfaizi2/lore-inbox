Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273115AbRI3IR3>; Sun, 30 Sep 2001 04:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRI3IRT>; Sun, 30 Sep 2001 04:17:19 -0400
Received: from otter.mbay.net ([206.40.79.2]:59653 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S273137AbRI3IRJ> convert rfc822-to-8bit;
	Sun, 30 Sep 2001 04:17:09 -0400
From: John Alvord <jalvo@mbay.net>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
Date: Sun, 30 Sep 2001 01:17:31 -0700
Message-ID: <ltkdrt4cie5s1ecggktl6m4aj7ht9n5dv6@4ax.com>
In-Reply-To: <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net> <E15nNpb-0002KX-00@fenrus.demon.nl>
In-Reply-To: <E15nNpb-0002KX-00@fenrus.demon.nl>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001 18:23:15 +0100, arjan@fenrus.demon.nl wrote:

>In article <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net> you wrote:
>
>> One aspect that bothers me is the absence of a success criteria.
>
>I disagree here. Red Hat uses "must pass the cerberus test" as one of the
>criteria for kernels. The are other similar criteria, most are obvious (must
>boot :). All other distributions have similar tests and a few even use the
>cerberus testsuite as well.
I believe you. I was worrying about the developer transition from 2.4
to 2.5, not the excellent work that the distributors do.

>
>Maybe your problem is "absence of tests before Linus releases", well 
>even that isn't fully true as distros run these tests on -pre kernels as
>well (or -ac kernels, which are mostly in sync with -pre kernels)...
As mentioned, I am not worried about the distributions.

>
>> The current competition for best VM is a good example. The fact is that
>> every operating system will fail with a high enough load. The best you can
>> hope for is a better degradation then the prior release.
>
>There are a few basic creteria here as well, and 2.4.10 fails on some of
>them so far:
>
>1) Must not kill processes as long as there is plenty of swap
>   or (possibly dirty) cache memory
>2) Must not deadlock (as that is a code-bug)
>3) Must not livelock without any progress
Is this criteria explicity accepted by all parties? And is it the only
criteria?

>
>Note that no 2.4 kernel so far really achieves 1) in the presence of
>highmem; the obvious deadlocks are just pushed further by tuning.
>
>> At the moment both 2.4.10 and 2.4.9-ac16 are better then 2.2.19. But
>> people keep testing under higher and higher loads and (surprise) they both
>> fail... initiating a search for better degradation logic.
>
>2.4.10 isn't better than 2.2.19 given the criteria above. 2.4.10aa2 might
>be though... and 2.4.9acX+Rik's patches are solid in testing. 

I read all sorts of reports, many positive and some negative.

john alvord
