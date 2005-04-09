Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDIIvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDIIvD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVDIIvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:51:03 -0400
Received: from mail.zmailer.org ([62.78.96.67]:48032 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S261184AbVDIIu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:50:57 -0400
Date: Sat, 9 Apr 2005 11:50:56 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel maintainers + drm users plz read also...)
Message-ID: <20050409085056.GK3858@mea-ext.zmailer.org>
References: <Pine.LNX.4.58.0503281236330.27073@skynet> <20050407114933.GH3858@mea-ext.zmailer.org> <Pine.LNX.4.58.0504071334560.25035@skynet> <20050407125345.GI3858@mea-ext.zmailer.org> <Pine.LNX.4.58.0504071357020.25035@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504071357020.25035@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 02:00:07PM +0100, Dave Airlie wrote:
> > My lattest runs were with 2 days old FC development (a.k.a. "bleeding edge")
> > environment with  xorg-11-** of same age.  Then I noticed that these DRM
> > patches didn't make it into  kernel-smp-2.6.11-1.1226_FC4.i686.rpm,
> > and I made 2.6.12-rc2 -- just in case it had fixed the problem...
> 
> well these patches shouldn't really affect it..

  :-(
 
> > Could the card-lockups be recovered in a bit nicer way ?
> > (And detected, too!)
> 
> In theory yes, but there isn't really anything you can do except reboot,
> as usually the CP (command processor) is hung, and you have to do a full
> GPU reset, I can't imagine X or Linux consoles surviving it too well...
> ATI have a VPU Recover in their windows driver which does it.. but they
> know their cards a bit better than we do..
> 
> it might be worth turning Render acceleration off Option "RenderAccel"
> "No" in xorg.conf and see if it gets any stabler...

With that option set, the TuxRacer didn't hang anywhere in practice
fields, but choosing "Credits" did hang the system in seconds.

> Dave.
> -- 
> David Airlie, Software Engineer
> http://www.skynet.ie/~airlied / airlied at skynet.ie
> Linux kernel - DRI, VAX / pam_smb / ILUG

  /Matti
