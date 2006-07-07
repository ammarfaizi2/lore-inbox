Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWGGPTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWGGPTW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 11:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWGGPTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 11:19:22 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:29499 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWGGPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 11:19:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kh+vHogMZbiRT227+cIjiiB4p8wkjm+aOqS77id4UK+itmdsV8pqBvLG2lpgwy2QVTuOVHLHI985UOa1xEX1gH3fK0ZrS5TUlgL+ivZYIGQrhJwPoaCGQRf1wSERjW46x6uCrawcx25V1BGbaFFZkgzT0wxG9Ir5KEn3DHwrKNo=
Message-ID: <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com>
Date: Fri, 7 Jul 2006 08:19:21 -0700
From: "Avuton Olrich" <avuton@gmail.com>
To: "Jan Rychter" <jan@rychter.com>
Subject: Re: swsusp / suspend2 reliability
Cc: linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
In-Reply-To: <m2k66qzgri.fsf@tnuctip.rychter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606270147.16501.ncunningham@linuxmail.org>
	 <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au>
	 <20060627154130.GA31351@rhlx01.fht-esslingen.de>
	 <20060627222234.GP29199@elf.ucw.cz>
	 <m2k66qzgri.fsf@tnuctip.rychter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/06, Jan Rychter <jan@rychter.com> wrote:
> >>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:
>  Pavel> Hi!
>  >> > uswsusp is a great idea, really.. I love it.. but suspend2 is
>  >> > here, it works, it's stable and it's now. Why continue to deprive
>  >> > the mainstream of these features because "uswsusp should".. as yet
>  >> > it doesn't.. and when it does then we can phase out the currently
>  >> > stable, working alternative that has all these features that
>  >> > uswsusp _will_ have, after it's had them for a year or so and its
>  >> > been proven stable. Not only that, I'll be happy to migrate over
>  >> > to it. Until then however, you can pry suspend2.. cold,
>  >> > dead.. blah blah..
>  >>
>  >> Given the above explanation, it's obvious that I'm an outside
>  >> watcher now, but if swsusp2 success rate is clearly higher than the
>  >> standard version, then I'd also strongly advocate this direction
>  >> since, quite frankly,
>
>  Pavel> I do not think suspend2 works on more machines than in-kernel
>  Pavel> swsusp. Problems are in drivers, and drivers are shared.
>
>  Pavel> That means that if you have machine where suspend2 works and
>  Pavel> swsusp does not, please tell me. I do not think there are many
>  Pavel> of them.
>
> Accept the facts -- for some reason, there is a fairly large user base
> that goes to all the bother of using suspend2, which requires
> downloading, patching and all the extra work. People do it, in spite of
> the wonderful swsusp being in the kernel and all the other extra cool
> stuff being worked on.

As I've said in previous threads, I've had a much higher rate of
sucess with suspend2 than swsusp, much like others who are replying to
this thread. Can anyone tell me, did Suspend2 get veto'd? If not has
there been a clear laid-out plan of what needs to be done to get this
in to the kernel? Is adding new in-kernel suspend code not an option
now? This is not about eye-candy but simply getting computers to
suspend-to-disk. If that part of suspend2 never makes it into the
kernel I couldn't care less.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
