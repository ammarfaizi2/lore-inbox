Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275278AbRJVLaj>; Mon, 22 Oct 2001 07:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278727AbRJVLa3>; Mon, 22 Oct 2001 07:30:29 -0400
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:2825 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S275278AbRJVLaT>; Mon, 22 Oct 2001 07:30:19 -0400
Message-ID: <hwHwJtbLMA17Ew7i@wookie.demon.co.uk>
Date: Mon, 22 Oct 2001 12:29:15 +0100
Cc: linux-kernel@vger.kernel.org
From: John Beardmore <wookie@wookie.demon.co.uk>
Subject: Re: ISDN cards and SMP
In-Reply-To: <NPHLGxZPH$07EwlQ@wookie.demon.co.uk> <4947.1003748210@redhat.com>
In-Reply-To: <4947.1003748210@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=us-ascii;format=flowed
User-Agent: Turnpike/6.00-U (<F7naP4S4l2F1q+EHsIexcg5ozp>)
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <4947.1003748210@redhat.com>, David Woodhouse 
<dwmw2@infradead.org> writes
>wookie@wookie.demon.co.uk said:

>>  This works fine with a single processor kernel, but the module fails
>> to load with a kernel compiled for SMP.
>
>> I gather this is true for all the Isdn4Linux drivers, though as I have
>> a three processor machine, this is a real pain !
>
>The HiSax driver should be fine -

This is hisax.  What version are you using ?  Maybe it's been sorted in 
the last year or so ?


> I use it 100% of the time (or at least
>100% of the time we have power to the house) on my SMP box at home,

:)   !


> without
>trouble. I see no reason why the other drivers would have problems.

OK, but I've been told by other people that there are problems and this 
is consistent with my experience of this release.


>If you're having problem with modules loading, there's probably a
>compilation problem.

It seems odd that that the module compiles and links OK, and loads into 
a uniprocessor kernel if it's broken in any way.  Or can it be broken in 
some subtle SMP specific way ?


> If you're using a distro kernel, check it's installed
>properly.

I've built it from the sources that shipped with RH 6.2 using the GUI 
tool to specify SMP support.  I think it's installed properly in as far 
as all three CPUs get used once its installed.  Very cute !  Roll over 
NT etc !


> If you're building your own, rebuild it and the modules.

I can do, but I'd like to know what to do differently first.


Cheers, J/.
-- 
John Beardmore
