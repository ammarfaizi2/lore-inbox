Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbULTVf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbULTVf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbULTVeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 16:34:07 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:53403 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261658AbULTVcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 16:32:14 -0500
Subject: Re: [linux-usb-devel] Re: Scheduling while atomic (2.6.10-rc3-bk13)
From: Lee Revell <rlrevell@joe-job.com>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>,
       Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200412201331.35652.david-b@pacbell.net>
References: <20041219231015.GB4166@mail.muni.cz>
	 <200412201152.16329.david-b@pacbell.net>
	 <1103576264.1252.87.camel@krustophenia.net>
	 <200412201331.35652.david-b@pacbell.net>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 16:32:10 -0500
Message-Id: <1103578330.1252.97.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 13:31 -0800, David Brownell wrote:
> On Monday 20 December 2004 12:57 pm, Lee Revell wrote:
> > On Mon, 2004-12-20 at 11:52 -0800, David Brownell wrote:
> > > Here's a quick'n'dirty patch, msleep --> mdelay.  I'd rather
> > > not mdelay for that long, but this late in 2.6.10 it's safer.
> > > (And this is also what OHCI does in that same code path.)
> > 
> > Ugh.  20ms is WAY too long to hold a spinlock.  That's guaranteed to
> > cause audio skips.
> 
> During system resume?  :)
> 

Sorry, should have read the whole thread ;-)

Lee

