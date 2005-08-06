Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263492AbVHFURF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbVHFURF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 16:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263512AbVHFURF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 16:17:05 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:4799 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263492AbVHFURE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 16:17:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WCu9f9p7rJdJbRcKkLomHNfF7hdAOKH0pJTljzeHIOMtkuz53dYJx/Ew4rTCtyRwlH88lloVdDnsrARc/Lqtla6YjAF5fOFH1VKzyETYAzBIiWT8pzU9o63e9USN2OgJrknMBcIRLMc+OfWlORYQsD87xivkPlFzJwlqgrirnF8=
Message-ID: <de63970c0508061317d4744f@mail.gmail.com>
Date: Sat, 6 Aug 2005 21:17:02 +0100
From: Simon Morgan <sjmorgan@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Outdated Sangoma Drivers
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42F5090E.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <de63970c05080602496c2c8b11@mail.gmail.com>
	 <42F5090E.4070608@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> It is true that wanpipe drivers are not part of linux 2.6 kernel.  We have
> been so busy developing that there is no way the linux kernel could
> keep up with the changes.

I guess this is the key statement and I'm not really the one to judge
whether or not the kernel could "keep up with the changes" but if
they mean the kernel development process then surely they're
wrong?

> Bottom line we have to put a whole new wanpipe driver into the kernel
> source, and that is a big task.

Surely it can't be that big a task if they distribute a shell script with their
drivers that does it automagically?

> It is much easier for us to ask people to use our drivers from the web.
> Once the wanpipe drivers stop changing so fast we will be able
> to push the new release into the kernel.  It doesn't make sense to do it
> now because if anyone wants to use wanpipe, that person would have
> to get the latest drivers from the web!

They're obviously working against a copy of the kernel when they write their
drivers so I don't see how difficult it would be to submit incremental diff's
for inclusion or at least the diff's between each stable version.

But I digress.. I guess it comes down to whether anybody is willing to put
in the effort to incorporate the current version into the kernel. If
not then, like
Adrian says, it's probably best just to leave it for the time being and if later
on down the line they still haven't submitted an updated version then
incorporating one or removing the old one. I'd be more willing to do the
former if I had more than 0 experience of kernel development.
