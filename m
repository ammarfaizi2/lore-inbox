Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVESHQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVESHQu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 03:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbVESHQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 03:16:50 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:17613 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262404AbVESHQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 03:16:48 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Date: Thu, 19 May 2005 17:18:55 +1000
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <377362e10505181142252ec930@mail.gmail.com> <200505190756.16413.kernel@kolivas.org> <377362e1050518235812f1cbbb@mail.gmail.com>
In-Reply-To: <377362e1050518235812f1cbbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505191718.55615.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 May 2005 04:58 pm, Tetsuji "Maverick" Rai wrote:
> On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> > ------------snip---------------
> > Hyperthread sibling cpus share cpu power. If you let a nice 19 task run
> > full power on the sibling cpu of a nice 0 task it will drain performance
> > from the nice 0 task and make it run approximately 40% slower. The only
> > way around this is to temporarily make the sibling run idle so that a
> > nice 0 task gets the appropriate proportion of cpu resources compared to
> > a nice 19 task. It is intentional and quite unique to the linux cpu
> > scheduler as far as I can tell. On any other scheduler or OS a nice 19
> > "background" task will make your machine run much slower.
> >
> Thanks.   I understood it's a feature of linux kernel and am satisfied
> with it.  Actually on Windows xp my application sometimes slows down
> maybe due to inpropoer scheduler.

Well I invented it so it's very unlikely that Windows* will have it (?yet) :D

Cheers,
Con
