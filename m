Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbWJYPIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbWJYPIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWJYPIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 11:08:47 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:31414 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932454AbWJYPIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 11:08:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dcff7BPC97l+etUedd42AOsFa5fB0ayrrDvXsL4q/XiQl8zzb/TYqNwGjiZWWjJM25jX5CO6KIcUV97B4zca4r8Y6Hh06yugrRVg9LtXJIE7XUaLD0NjOGTBnO5/vI71vex3wW1G+JYWCnfujKz/F5CQAdIKPX2j41FFUX/5BYk=
Message-ID: <2c0942db0610250808w64e60229reede9b9da2bb88dd@mail.gmail.com>
Date: Wed, 25 Oct 2006 08:08:45 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: Michael <michael.sallaway@gmail.com>
Subject: Re: PROBLEM: Oops when doing disk heavy disk I/O
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <453f585d.299e45f8.4666.371b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2c0942db0610242112r738fe4ccg8702ef5175a7927c@mail.gmail.com>
	 <453f585d.299e45f8.4666.371b@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/06, Michael <michael.sallaway@gmail.com> wrote:
> > Try swapping out the RAM (or getting it down to 1Gig). Try a really
> > old kernel, such as debian's 2.6.8 package.
>
> Well, what do you know -- that seems to have fixed it! I took out one stick
> of RAM (so it's down to 1 gig) and it seems to work fine, now, without any
> boot parameters or anything. (mind you, murphy's law will dictate that it'll
> crash about 30 seconds after I send this...)
>
> I'm amazed at that -- but I'm not going to look a gift horse in the mouth,
> this has been frustrating me for far too long. :-)
>
> Although, having said that, I'm curious... It is working because there's
> only 1 gig of RAM in there, or because it's only a single stick (ie. not
> dual-channel)? It works fine with both sticks, individually, just not both
> together... I wonder what the cause of it actually is...

That I don't know. Marginal power supplies can cause very strange
problems, or there can be motherboard/memory timing issues with lots
of RAM, or just plain old more-than-one-gig-of-RAM-tickles-software
bugs. Though the latter, especially on an x86-64 kernel, really
shouldn't be very common if present at all.

What I'd suggest is resending to the list the first oops after boot
(several of them would be good) while using 2 gigs of RAM, with a new
subject line to attract those who are especially good at reading these
things. (I can barely find the stack trace.)

Ray
