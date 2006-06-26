Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWFZRPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWFZRPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFZRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 13:15:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:866 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751110AbWFZRP3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 13:15:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hAbQvkPCpxzNdGcEZPIu3sxA9v13WY/K9s4k6+ihnGyHW8bUiGMX4U4BKFhHddC/57ZCYZayFGz1EX+J4B4KDagBl81N/5CDWTmbT4+6UQz9UOEW8I4lzbiMi8JuM11wW3YxDNdzkBcbMvtxypwFzbkpfmRS8IwisRYO5YffA18=
Message-ID: <9e4733910606261015l13399f96hebebeb00b6b01790@mail.gmail.com>
Date: Mon, 26 Jun 2006 13:15:25 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: [PATCH] Kconfig for radio cards to allow VIDEO_V4L1_COMPAT
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1151341122.13794.2.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <9e4733910606251040v62675399gdfe438aaac691a5a@mail.gmail.com>
	 <1151327213.3687.13.camel@praia>
	 <9e4733910606260855kf2e57ado5c69d8295d1be5@mail.gmail.com>
	 <1151341122.13794.2.camel@praia>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Jon,
>
> Em Seg, 2006-06-26 às 11:55 -0400, Jon Smirl escreveu:
> > On 6/26/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
>
> > > All radio stuff at kernel are still using the old obsoleted V4L1 API,
> > > and requires some changes to be V4L2 compliant. The correct fix is to
> > > replace the old calls to V4L2 calls, and include videodev2.h header
> > > instead of videodev.h.
> >
> > Is anyone who knows how V4L2 works going to port those drivers?
> Nobody started working on it yet.
>
> > I would hate to see 20 device drivers lost because they weren't ported
> > and V4L1 gets removed.
> The driver conversion shouldn't be that hard. The main problem is that
> those devices are really obsolete hardware and none of the current V4L
> developers have those boards for testing. Do you have any of those
> devices? Can you help porting it to V4L2?

I don't have any of the hardware. I was just doing some work on
Kconfig and noticed that a bunch of drivers had gone missing. I see
now that a lot of the drivers in media/video have the same problem. I
guess V4L1 is going to be with us for a while longer since all of
these drivers need to get ported.

-- 
Jon Smirl
jonsmirl@gmail.com
