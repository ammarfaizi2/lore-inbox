Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUIWA1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUIWA1w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 20:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUIWA1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 20:27:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:18910 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265222AbUIWA12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 20:27:28 -0400
Date: Wed, 22 Sep 2004 17:26:49 -0700
From: Greg KH <greg@kroah.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Dave Aubin <daubin@actuality-systems.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there a user space pci rescan method?
Message-ID: <20040923002649.GA28259@kroah.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <415211A8.8040907@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415211A8.8040907@ppp0.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 01:58:32AM +0200, Jan Dittmer wrote:
> Dave Aubin wrote:
> > Hi,
> > 
> >   I know very little about hotplug, but does make sense.
> > How do you motivate a hotplug insertion event?  Or should
> > I just go read the /docs on hotplugging?  Any help is
> > Appreciated:)
> 
> There is a "fake" hotplug driver which works for normal pci. But last
> time I looked at it, it did only support hot disabling, not hot enabling
> - but this surely can be fixed.

Yes, hot "enabling" has been left for someone to add to the driver, if
you read the comments in it :)

Good luck,

greg k-h
