Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVBRXg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVBRXg3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVBRXg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 18:36:29 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:57249 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261557AbVBRXfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 18:35:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kuEEseWAmj3d9c20ekljUA1EfYEXBD2Ry7wBHep7qUdhnz/xKAt/gtm/guNMm+MMKxhwXNeMyfpO32kO2Od4aw8QlIEisj+b0U3QjLYG+XxoY0tdBY0ncrTTHo/xiNaRTTpgi69vUyr0iQyusXWmzJkimoSIqP7flGcmbc97nq0=
Message-ID: <9e473391050218153527cbb893@mail.gmail.com>
Date: Fri, 18 Feb 2005 18:35:49 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] Re: Hotplug blacklist and video devices
Cc: linux-fbdev-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1108767531.5631.29.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <1108767531.5631.29.camel@thor.asgaard.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2005 17:58:51 -0500, Michel Dänzer <michel@daenzer.net> wrote:
> > For example I'm looking at making changes to DRM such that DRM will
> > require the corresponding framebuffer driver to be loaded.
> 
> Ignoring my suspicion that people won't like stuff getting forced down
> their throats like this (why would a DRM _require_ a framebuffer
> device?), does the hotplug blacklisting of the framebuffer devices
> matter at all if the DRM depends on them, i.e. won't they be loaded
> regardless when the DRM is loaded?

There is no mechanism for getting a hotplug remove event into a driver
like DRM that doesn't attach to the PCI device.

-- 
Jon Smirl
jonsmirl@gmail.com
