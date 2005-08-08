Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVHHRZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVHHRZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbVHHRZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:25:41 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:693 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbVHHRZk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:25:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ovUYjaK93KdMJV8IdBaFY2ZOl9BExq/13gEbBRshH0uOV9aOdkJRGEVbcvLIf/jN7RMVjS9AoahBB8CdruJCPoVs/ltxac3m/xLXbBbX5XF+XxIbZAONIYJQDUfjQ+Z6fSib2FlGAlDs/uwFEaxIbADxs0L/KCUexxgTAaOvc8c=
Message-ID: <9268368b05080810255e8a67c0@mail.gmail.com>
Date: Mon, 8 Aug 2005 13:25:40 -0400
From: Daniel Petrini <d.pensator@gmail.com>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: Timertop - update
Cc: linux-kernel@vger.kernel.org, tony@atomide.com,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <200508081826.14298.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9268368b050808074579501f86@mail.gmail.com>
	 <200508081826.14298.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Small comment: I had to move the shell call (#!/usr/bin/perl) to the top of
> the file before i was able to start it.

Ok. I will change that. I was only using "perl timer_top.pl 5"
 
> One that comes back very often in timertop is:
> 
> c0124cf0|    510606|   314.40| process_timeout
> 
> Any idea what that is?

This is the timer scheduled by the schedule_timeout function. Some
driver is using that instead of  a new timer function.
 
> Thanks,
> 
> Jan

Thanks,
Daniel
-- 
10LE - Linux
INdT - Manaus - Brazil
