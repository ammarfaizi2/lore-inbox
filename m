Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVBJUFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVBJUFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVBJUFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:05:50 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:5764 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261619AbVBJUFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:05:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=o1bbF1LeFemBQgrmWND5P35mrGuDJS9G8GYwwJvkBc9aVzSzuLWygSgG9qVLQFr5BFpFEtuZfxWWkYikqg7BFonJ4BQPbpJVTNLscR177arOWL2a/YGLmTn+SARiIbjC7/GXgAU1b6jPFF3Gk7T9eE9q4Ws5AEBNs/mBkBEmNeg=
Message-ID: <58cb370e05021012051518e912@mail.gmail.com>
Date: Thu, 10 Feb 2005 21:05:13 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
Cc: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjan@infradead.org>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <420BB77B.3080508@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <420631BF.7060407@pobox.com> <420582C6.7060407@pobox.com>
	 <58cb370e05020607197db9ecf4@mail.gmail.com> <420BB77B.3080508@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005 14:35:23 -0500, Bill Davidsen <davidsen@tmr.com> wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Sun, 06 Feb 2005 10:03:27 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>Arjan van de Ven wrote:
> >>
> >>>>I consider it not a new feature, but a missing feature, since otherwise
> >>>>user data cannot be accessed in the RAID setups.
> >>>
> >>>
> >>>the same is true for all new hardware drivers and hardware support
> >>>patches. And for new DRM (since new X may need it) and new .. and
> >>>new ... where is the line?
> >>>
> >>>for me a deep maintenance mode is about keeping existing stuff working;
> >>>all new hw support and derivative hardware support (such as this) can be
> >>>pointed at the new stable series... which has been out for quite some
> >>>time now..
> >>
> >>Red herring.
> >>
> >>2.4.x has ICH5/6 support -- but is missing the RAID support component.
> >>
> >>We are talking about hardware that is ALREADY supported by 2.4.x kernel,
> >>not new hardware.
> >>
> >>We are also talking about inability to access data on hardware supported
> >>by 2.4.x, not something that can easily be ignored or papered over with
> >>a compatibility mode.
> >
> >
> > the same arguments can be used for crypto support etc.,
> > answer is - use 2.6.x or add extra patches to get 2.4.x working
> 
> It's fix in a sense. The hardware is supported now, just not very well.
> If an IDE chipset was capable of UDA4 and the driver only allowed UDA2
> it would be a fix, in this case thehardware is supported partially, the
> RAID conponent isn't working, and this is the fix.

The so called "RAID component" is 100% *software* solution.

BTW What is UDA?
