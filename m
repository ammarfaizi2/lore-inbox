Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132846AbRDPDaQ>; Sun, 15 Apr 2001 23:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132848AbRDPDaG>; Sun, 15 Apr 2001 23:30:06 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:8689 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132846AbRDPD3r>; Sun, 15 Apr 2001 23:29:47 -0400
Date: Sun, 15 Apr 2001 23:29:09 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Joseph Carter <knghtbrd@debian.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, nicholas@petreley.com,
        linux-kernel@vger.kernel.org
Subject: Re: usb-uhci.c problems in latest kernels?
Message-ID: <20010415232909.A28478@devserv.devel.redhat.com>
In-Reply-To: <20010414213546.A1590@devserv.devel.redhat.com> <20010415043836.C15118@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010415043836.C15118@debian.org>; from knghtbrd@debian.org on Sun, Apr 15, 2001 at 04:38:37AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 15 Apr 2001 04:38:37 -0700
> From: Joseph Carter <knghtbrd@debian.org>
> To: Pete Zaitcev <zaitcev@redhat.com>
> Cc: nicholas@petreley.com, linux-kernel@vger.kernel.org

> > > usb-uhci.c: interrupt, status 3, frame# 1876 
> > 
> > This is a known problem, here is the discussion that I initiated
> > on linux-usb-devel:
> > 
> >  http://marc.theaimsgroup.com/?t=98609508500001&w=2&r=1
> > 
> > The right fix is to comment that printout out.
> > In fact, that is what I commited for Red Hat 7.1 release.
> 
> I'm not sure of that.  Sometimes keys get "stuck" in the down position
> with my USB keyboard (mechanical switches, so the keys themselves are not
> sticking) and usually when that happens I can find a line like the one
> quoted above in the logs. [...]

The printout is a valuable diagnostic tool for hacking but
is useless for a user (actually dangerous, as it brings computers
down with /var overflow). The best option would be to have
it configurable with a module parameter.

-- Pete
