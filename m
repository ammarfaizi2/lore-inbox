Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVBFP2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVBFP2g (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVBFP2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:28:35 -0500
Received: from canuck.infradead.org ([205.233.218.70]:57096 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261165AbVBFP2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:28:33 -0500
Subject: Re: [ANNOUNCE] "iswraid" (ICHxR ataraid sub-driver) for 2.4.29
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Martins Krikis <mkrikis@yahoo.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <420631BF.7060407@pobox.com>
References: <87651hdoiv.fsf@yahoo.com> <420582C6.7060407@pobox.com>
	 <1107682076.22680.58.camel@laptopd505.fenrus.org>
	 <58cb370e050206044513eb7f89@mail.gmail.com>  <42062BFE.7070907@pobox.com>
	 <1107701373.22680.115.camel@laptopd505.fenrus.org>
	 <420631BF.7060407@pobox.com>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 16:28:20 +0100
Message-Id: <1107703700.22680.124.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-06 at 10:03 -0500, Jeff Garzik wrote:
> Arjan van de Ven wrote:
> >>I consider it not a new feature, but a missing feature, since otherwise 
> >>user data cannot be accessed in the RAID setups.
> > 
> > 
> > the same is true for all new hardware drivers and hardware support
> > patches. And for new DRM (since new X may need it) and new .. and
> > new ... where is the line?
> > 
> > for me a deep maintenance mode is about keeping existing stuff working;
> > all new hw support and derivative hardware support (such as this) can be
> > pointed at the new stable series... which has been out for quite some
> > time now..
> 
> Red herring.
> 
> 2.4.x has ICH5/6 support -- but is missing the RAID support component.
> 
> We are talking about hardware that is ALREADY supported by 2.4.x kernel, 
> not new hardware.

I'm talking about derivative hardware support. While this is not
technically a hardware device driver, it sure is similar to one.

> We are also talking about inability to access data on hardware supported 
> by 2.4.x, not something that can easily be ignored or papered over with 
> a compatibility mode.

It's a new feature. It's support for a hw related feature not previously
supported. Now you can argue if such a new feature is appropriate or
not, but I don't see any way of arguing that this is not a new feature.

