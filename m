Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273701AbRI0RJt>; Thu, 27 Sep 2001 13:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273702AbRI0RJj>; Thu, 27 Sep 2001 13:09:39 -0400
Received: from zeke.inet.com ([199.171.211.198]:34297 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S273701AbRI0RJZ>;
	Thu, 27 Sep 2001 13:09:25 -0400
Message-ID: <3BB35D53.CB561592@inet.com>
Date: Thu, 27 Sep 2001 12:09:39 -0500
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.19-6.2.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bill davidsen <davidsen@tmr.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] core file naming option
In-Reply-To: <3BB104A9.3AD512A5@inet.com> <200109271617.f8RGHkH08397@deathstar.prodigy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bill davidsen wrote:
> 
> In article <3BB104A9.3AD512A5@inet.com>,
> Eli Carter <eli.carter@inet.com> wrote:
> 
> | The attached patch adds an option to the build to have core files named
> | core.processname, but defaulting to the current behaviour of course.
> | For most people the single 'core' file is sufficient, but when the sky
> | is falling, it's nice to have more places for it to land.  :)
> | So, is this something that might go into the kernel, or are their
> | philisophical reasons against it?  (The patch is against 2.2.19.  I
> | haven't looked at 2.4.x yet.  Let me know if you want a 2.4 or if I
> | should send it to Linus, or...)
> |
> | Questions, comments, etc. welcome,
> 
>   Since you asked for it... ;-)

Thanks.  :)
 
>   While you're adding this feature, and it seems others are adding
> similar things, it is *highly* desirable to allow the build to put all
> the dumps in one place of desired (my  first thought is /var/core) so
> that if you get a lot you won't run the system out of disk.
> 
>   The directory name could be set in /proc/sys/coredir (or somesuch)
> with an initial value of "." of course.
> 
>   Other than that I like the idea, although process "name" could get a
> lot of clashes on threads, and pid gets reused. There may be a better
> idea, but most of mine are cumbersome. This would really simplify
> certain kinds of dump analysis.

I can see that those would be good improvements... but core.name is what
I can do (and get the time to do,) right now.

Eli
--------------------.     Real Users find the one combination of bizarre
Eli Carter           \ input values that shuts down the system for days.
eli.carter(a)inet.com `-------------------------------------------------
