Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965142AbWH2RTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWH2RTo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965170AbWH2RTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 13:19:44 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:9860 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965142AbWH2RTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 13:19:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DZ8l0//J35IGdchXaiC9j8dADMQo4ARMw7ZWi1qyc+KuUnrVShmRLaMpY8xyBVkdlgwveYL8Pg5WTFbqulFpO7aWeBndEy9RpclQhpHNbiCQlno01rGU0YEb3lkq3QPRpVosyuCa6+L9jnIwv9Z+9hjFzvwtVdabGNhcPAzhSP8=
Message-ID: <e6babb600608291019l7886aa9cs8147bb36d7848825@mail.gmail.com>
Date: Tue, 29 Aug 2006 10:19:42 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "hui Bill Huey" <billh@gnuppy.monkey.org>
Subject: Re: rtmutex assert failure (was [Patch] restore the RCU callback...)
Cc: "Esben Nielsen" <nielsen.esben@gmail.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, rostedt@goodmis.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060829171154.GA11627@gnuppy.monkey.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060823210558.GA17606@gnuppy.monkey.org>
	 <e6babb600608231822s1ce8b229ubdc85ce7544c6b4@mail.gmail.com>
	 <20060824014658.GB19314@gnuppy.monkey.org>
	 <20060825071957.GA30720@gnuppy.monkey.org>
	 <e6babb600608251824g7e61e28n1c453db05a4e773d@mail.gmail.com>
	 <20060826104923.GA7879@gnuppy.monkey.org>
	 <e6babb600608281133q3597c42dsa88820ddd82f9d01@mail.gmail.com>
	 <20060828202827.GA3625@gnuppy.monkey.org>
	 <e6babb600608282105v7d8c90b0g6631414b3f868e3c@mail.gmail.com>
	 <20060829171154.GA11627@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, hui Bill Huey <billh@gnuppy.monkey.org> wrote:
> I'm going to ask what seems like a really stupid question. What's "t6" ?
> and what's the relationship of that to my patches ?

Oh, sorry, thought I'd made that clear.  Since the first patches you
put up were "t.diff" and "t2.diff", I've just been incrementing a
counter:

-rw-r--r-- 1 rcrocomb rcrocomb  1941 Aug 14 08:28 t.diff
-rw-r--r-- 1 rcrocomb rcrocomb  5875 Aug 14 08:28 t2.diff
-rw-r--r-- 1 rcrocomb rcrocomb  9397 Aug 21 15:25 t3.diff
-rw-r--r-- 1 rcrocomb rcrocomb 11289 Aug 23 09:55 t4.diff
-rw-r--r-- 1 rcrocomb rcrocomb 15460 Aug 23 17:37 t5.diff
-rw-r--r-- 1 rcrocomb rcrocomb 18119 Aug 25 13:31 t6.diff

[rcrocomb@spanky patches]$ head t6.diff
#
# old_revision [c9c382f0a12ab75bee370938f9b7ad5b582cf39a]
#
# patch "arch/x86_64/kernel/smp.c"
#  from [b354a6e4a080ad49f4213ab4334ca2e57ddf1bdc]
#    to [a76a90aaad275ab3775d32ac3ae500fe120c5b8c]
#
# patch "arch/x86_64/mm/numa.c"
#  from [72976a7a4aff795f020f34e91e98e0defa280d3b]
#    to [9f2858d19a369e3aceaf084796837bd02e9bc6b7]

> [side note: I'm headed to Burning Man tomorrow and won't be on a computer
> for 6 days until I come back]

Nice!

-- 
Robert Crocombe
rcrocomb@gmail.com
