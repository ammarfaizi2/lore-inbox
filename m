Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268773AbTCCUVD>; Mon, 3 Mar 2003 15:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268775AbTCCUVC>; Mon, 3 Mar 2003 15:21:02 -0500
Received: from havoc.daloft.com ([64.213.145.173]:6378 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268773AbTCCUU4>;
	Mon, 3 Mar 2003 15:20:56 -0500
Date: Mon, 3 Mar 2003 15:31:15 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Pavel Roskin <proski@gnu.org>
Cc: David Hinds <dhinds@sonic.net>,
       David Hinds <dahinds@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fallback to PCI IRQs for TI bridges
Message-ID: <20030303203115.GD6615@gtf.org>
References: <Pine.LNX.4.50.0302281944470.6367-100000@marabou.research.att.com> <20030301093814.A6700@sonic.net> <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303031203300.17551-100000@marabou.research.att.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 12:26:54PM -0500, Pavel Roskin wrote:
> Hi, David!
> 
> > > yenta_socket in 2.5.63 knows different models of the bridges and sets IRQ
> > > routing to PCI for certain models.  I don't really like this approach.
> >
> > I have not looked at the most recent 2.5.* kernels but if that is true
> > then you're right, it is ill conceived.
> 
> I'm not aware of the "political" situation around PCMCIA drivers, but I
> think it's sad that the kernel drivers are pushed (e.g. by Red Hat) in the
> hope that they will get more visibility and will be improved, but the
> people who have the best expertize still use pcmcia-cs drivers and work on
> improving them.

Red Hat "pushes" exactly what the Linux community supports:

This is also called "tracking upstream" and/or "working with the Linux
community, and following the Linux community's decisions."  This is
_not_ a political situation at all.  We simply ship what the community
supports.  Red Hat would not be good "open source citizens" if they did
otherwise.

Taking off my Red hat, and donning my "personal opinion" hat, I think
the kernel cardbus support has been very effectively.  It allows drivers
such as tulip and 8139too and epic100 and 3c59x to Just Work(tm),
without any modification besides PCI id table updates.  Nothing external
required.  That's a huge boon to programmers and maintainers.

	Jeff



