Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWBWRcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWBWRcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWBWRcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:32:52 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:10190 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932098AbWBWRcv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:32:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bjHDKC7GBjZ+WrezogEuVSYDUp2gGh1Lp4mgFCrxI3u/mhBh2kRPAhU/A184XeZFt9HrGpUr3ZY0pbqAHIMvVkabU6FJbWHI8jMMh+HkRjbwR5G56/1HvI82WYiJme/pDdhyc7/Ty6/ewe0sCpqpHawZrOWzavfpxWUBQcmDJz8=
Message-ID: <4807377b0602230932n79dde5b7ue3851941bc15ca70@mail.gmail.com>
Date: Thu, 23 Feb 2006 09:32:50 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: Intel CSA Gigabit Bug in IC7-G Motherboards- Affects Windows/Linux
Cc: linux-kernel@vger.kernel.org,
       "Jesse Brandeburg" <jesse.brandeburg@intel.com>
In-Reply-To: <Pine.LNX.4.64.0602220527550.19732@p34>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602191807001.7212@p34>
	 <1140392860.2733.433.camel@mindpipe>
	 <Pine.LNX.4.64.0602191848230.7212@p34>
	 <4807377b0602192359g39c3a2fbnffaead2694788783@mail.gmail.com>
	 <Pine.LNX.4.64.0602201709510.3941@p34>
	 <Pine.LNX.4.64.0602220527550.19732@p34>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> Jesse,
>
> Any idea what is going on? MB defect? Driver defect?

well, no-napi shouldn't fail any worse than napi, so that may well be
a driver bug.  Lets follow up offline or at mailing list e1000-devel %
lists.sf.net

otherwise no idea.  There are a lot of people using these boards
without issues, it seems that ABIT even has some of this same board
that work for some people.  If you can find someone that has one that
works you might try comparing your ethtool -e output to theirs. If you
change your eeprom however, thats you taking risks on your own, and we
can't support you.  But it might be a useful thing to know, to give
more information to ABIT.

Jesse
