Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVDGMxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVDGMxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 08:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVDGMxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 08:53:48 -0400
Received: from mail.zmailer.org ([62.78.96.67]:52715 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262452AbVDGMxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 08:53:46 -0400
Date: Thu, 7 Apr 2005 15:53:45 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dave Airlie <airlied@linux.ie>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [bk tree] DRM add a version check.. for 2.6.12 (distro kernel maintainers + drm users plz read also...)
Message-ID: <20050407125345.GI3858@mea-ext.zmailer.org>
References: <Pine.LNX.4.58.0503281236330.27073@skynet> <20050407114933.GH3858@mea-ext.zmailer.org> <Pine.LNX.4.58.0504071334560.25035@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504071334560.25035@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 01:38:52PM +0100, Dave Airlie wrote:
> > I tried 2.6.12-rc2 which includes this patch, and I get DRM failures
> > here, which causes application and X to hang.  (I got failures with 2.6.11
> > also.)
> 
> Does the FC-4 test kernel work? There was a bug in X6.8.2 but I think it
> would be fixed in FC-4 test.. I run Xorg CVS on a 9200 with the latest
> kernel and it seems fine... granted I've been able to crash it with
> running a few wierd apps.. I've just had no chance to debug it yet but it
> isn't the common case... maybe I should play tuxracer for a while..
> 
> the symptoms are typical of a card lockup, spinning in ioctl forever...
> 
> Dave.

My lattest runs were with 2 days old FC development (a.k.a. "bleeding edge")
environment with  xorg-11-** of same age.  Then I noticed that these DRM
patches didn't make it into  kernel-smp-2.6.11-1.1226_FC4.i686.rpm,
and I made 2.6.12-rc2 -- just in case it had fixed the problem...

Could the card-lockups be recovered in a bit nicer way ?
(And detected, too!)

  /Matti Aarnio
