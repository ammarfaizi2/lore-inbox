Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVGDTw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVGDTw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 15:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGDTw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 15:52:27 -0400
Received: from nproxy.gmail.com ([64.233.182.201]:59750 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261607AbVGDTvz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 15:51:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q3DsqcaZp1jI9F/FiEUbEYXx5fgPIt3qhGF+QMtoarUeuQidGQWey5/cskMl5uAMNQNzUB8tMvBwHmvhdbja+Hy6T1lIKkb1lFpZmmQCID+Km/kOXy6K3fdXUQLqguNEsIFGDg+9uAaBEddB3Z9cAvSz0p0ZJJBw7r+HKmxp9vQ=
Message-ID: <58cb370e0507041251dd5a@mail.gmail.com>
Date: Mon, 4 Jul 2005 21:51:45 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [git patches] IDE update
Cc: Al Boldi <a1426z@gawab.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <42C9742E.8000204@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507041706.UAA11178@raad.intranet>
	 <42C9742E.8000204@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/05, Ondrej Zary <linux@rainbow-software.org> wrote:
> Al Boldi wrote:
> > Bartlomiej Zolnierkiewicz wrote: {
> >
> >>On 7/4/05, Al Boldi <a1426z@gawab.com> wrote:
> >>Hdparm -tT gives 38mb/s in 2.4.31
> >>Cat /dev/hda > /dev/null gives 2% user 33% sys 65% idle
> >>
> >>Hdparm -tT gives 28mb/s in 2.6.12
> >>Cat /dev/hda > /dev/null gives 2% user 25% sys 0% idle 73% IOWAIT
> >>
> >>It feels like DMA is not being applied properly in 2.6.12.
> >
> >
> > Are earlier 2.6.x kernels okay?
> >
> > dmesg output?
> > }
> >
> > Same on 2.6.10,11,12.
> > No errors though, only sluggish system.

What about earlier kernels?

Please try to narrow down the problem to a specific kernel version.

> Something like this http://lkml.org/lkml/2005/6/13/1 ?

It doesn't seem like IDE regression but...

Bartlomiej
