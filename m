Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275240AbTHGLZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 07:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275242AbTHGLZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 07:25:46 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:37762 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S275240AbTHGLZm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 07:25:42 -0400
Subject: Re: [Dri-devel] Re: any DRM update scheduled for 2.4.23-pre?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: arjanv@redhat.com, Mikael Pettersson <mikpe@csd.uu.se>, faith@valinux.com,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mitch@0Bits.COM
In-Reply-To: <200308061743.46570.m.c.p@wolk-project.de>
References: <16177.5641.6571.273023@gargle.gargle.HOWL>
	 <200308061714.36595.m.c.p@wolk-project.de>
	 <1060184267.5848.6.camel@laptop.fenrus.com>
	 <200308061743.46570.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060255303.3123.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 12:21:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-06 at 16:44, Marc-Christian Petersen wrote:
> > did you clean the tree up like in -ac's tree or did you take it as is
> > from some cvs repo ?
> nope, cvs. If Alan will be so kind to send me the fixes he made and I don't 
> have to do the double-work, I'll integrate and test them up.

Your code won't work with 4.1 users i810 at least then, and has some
other problems that were fixed over time.

> Or another choice would be that Alan will send his drm 4.3 code to Marcelo 
> once .22 final is out for .23-pre1 inclusion.

I can send him the -ac one minus the small change for the memory accounting
stuff easily enough. Thats a tree which lots of people have run (both vendor
and non vendor) so its probably a safer pick.

