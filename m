Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261550AbVBRW7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261550AbVBRW7g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 17:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVBRW7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 17:59:34 -0500
Received: from mail-res.bigfish.com ([63.161.60.61]:61122 "EHLO
	mail31-res-R.bigfish.com") by vger.kernel.org with ESMTP
	id S261548AbVBRW7T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 17:59:19 -0500
X-BigFish: V
Subject: Re: [Linux-fbdev-devel] Re: Hotplug blacklist and video devices
X-Sybari-Trust: 5e309461 4d512669 54ac7474 00000108
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 18 Feb 2005 17:58:51 -0500
Message-Id: <1108767531.5631.29.camel@thor.asgaard.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 16:14 -0500, Jon Smirl wrote:
> On Fri, 18 Feb 2005 16:08:22 -0500, Bill Nottingham <notting@redhat.com> wrote:
> > Under Fedora (and RHEL), they're there because we generally
> > don't want to load them unless the user asked for them.
> 
> Is there a specific reason why they are blocked? 

One reaseon might be that the framebuffer devices can cause problems,
e.g. with proprietary X drivers.

> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded.

Ignoring my suspicion that people won't like stuff getting forced down
their throats like this (why would a DRM _require_ a framebuffer
device?), does the hotplug blacklisting of the framebuffer devices
matter at all if the DRM depends on them, i.e. won't they be loaded
regardless when the DRM is loaded?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer

