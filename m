Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWFBEgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWFBEgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWFBEgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 00:36:47 -0400
Received: from smtp.enter.net ([216.193.128.24]:58642 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1751117AbWFBEgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 00:36:47 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: OpenGL-based framebuffer concepts
Date: Fri, 2 Jun 2006 00:36:39 +0000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com> <pan.2006.06.02.04.34.36.227639@sci.fi>
In-Reply-To: <pan.2006.06.02.04.34.36.227639@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606020036.39773.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 June 2006 04:34, Ville Syrjälä wrote:
> On Fri, 02 Jun 2006 11:15:47 +1000, Dave Airlie wrote:
> >> Without specifying a design here are a few requirements I would have:
> >>
> >> 1) The kernel subsystem should be agnostic of the display server. The
> >> solution should not be X specific. Any display system should be able
> >> to use it, SDL, Y Windows, Fresco, etc...
> >
> > of course, but that doesn't mean it can't re-use X's code, they are
> > the best drivers we have. you forget everytime that the kernel fbdev
> > drivers aren't even close, I mean not by a long long way apart from
> > maybe radeon.
>
> matroxfb is clearly better than the X driver. atyfb too IMO.

Hopefully the work me, Dave and Tony are doing is going to make it a level 
field. If it still doesn't improve things you are still free to use the fbcon 
system. THat's one part of the design that will not change.

DRH
