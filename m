Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUL3U4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUL3U4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 15:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbUL3U4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 15:56:45 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:38119 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261714AbUL3U4k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 15:56:40 -0500
Message-ID: <41D46B14.2080301@verizon.net>
Date: Thu, 30 Dec 2004 15:54:44 -0500
From: berk walker <berk.walker@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: "Peter T. Breuer" <ptb@lab.it.uc3m.es>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
References: <m3is6k4oeu.fsf@reason.gnu-hamburg> <m38y7fn4ay.fsf@reason.gnu-hamburg> <v3rda2-hjn.ln1@news.it.uc3m.es> <41D45C1F.5030307@tls.msk.ru>
In-Reply-To: <41D45C1F.5030307@tls.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [151.197.226.92] at Thu, 30 Dec 2004 14:56:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:

> Peter T. Breuer wrote:
>
>> In gmane.linux.raid Georg C. F. Greve <greve@fsfeurope.org> wrote:
>>
>> Yes, well, don't put the journal on the raid partition. Put it
>> elsewhere (anyway, journalling and raid do not mix, as write ordering
>> is not - deliberately - preserved in raid, as far as I can tell).
>
>
> This is a sort of a nonsense, really.  Both claims, it seems.
> I can't say for sure whenever write ordering is preserved by
> raid -- it should, and if it isn't, it's a bug and should be
> fixed.  Nothing else is wrong with placing journal into raid
> (the same as the filesystem in question).  Suggesting to remove
> journal just isn't fair: the journal is here for a reason.
> And, finally, the kernel should not crash.  If something like
> this is unsupported, it should refuse to do so, instead of
> crashing randomly.
>
> /mjt
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
I might have missed some of this thread....
but have you tried this on a completely different box?  I have seen, and 
am fighting some problems such as yours, and having nothing to do with raid.

If you haven't, then try it.  You might get different results.  Hardware 
can sometimes be a dog to chase down, problemwise.
b-

