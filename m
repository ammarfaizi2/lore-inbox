Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbULUWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbULUWWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbULUWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 17:22:55 -0500
Received: from thunk.org ([69.25.196.29]:59370 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261882AbULUWWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 17:22:50 -0500
Date: Tue, 21 Dec 2004 17:19:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@stusta.de>,
       Dan Dennedy <dan@dennedy.org>, Ben Collins <bcollins@debian.org>,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041221221924.GA12709@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lee Revell <rlrevell@joe-job.com>, Greg KH <greg@kroah.com>,
	Adrian Bunk <bunk@stusta.de>, Dan Dennedy <dan@dennedy.org>,
	Ben Collins <bcollins@debian.org>,
	Linux1394-Devel <linux1394-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20041220015320.GO21288@stusta.de> <1103508610.3724.69.camel@kino.dennedy.org> <20041220022503.GT21288@stusta.de> <1103510535.1252.18.camel@krustophenia.net> <1103516870.3724.103.camel@kino.dennedy.org> <20041220225324.GY21288@stusta.de> <1103583486.1252.102.camel@krustophenia.net> <20041221171702.GE1459@kroah.com> <1103649633.9220.12.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103649633.9220.12.camel@krustophenia.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 12:20:32PM -0500, Lee Revell wrote:
> On Tue, 2004-12-21 at 09:17 -0800, Greg KH wrote:
> > On Mon, Dec 20, 2004 at 05:58:06PM -0500, Lee Revell wrote:
> > > On Mon, 2004-12-20 at 23:53 +0100, Adrian Bunk wrote:
> > > > The solution is simple:
> > > > The vendor or services provider submits his driver for inclusion into 
> > > > the kernel which is the best solution for everyone.
> > > > 
> > > 
> > > What if the driver is under development and doesn't work yet?
> > 
> > Many drivers have been accepted into the kernel tree before they worked
> > properly :)
> 
> Yeah but I hope you can understand why someone would be hesitant to
> submit a broken driver.  It just makes the author look bad.  I would not
> feel right submitting something that didn't work.

That's what CONFIG_EXPERIMENTAL is for....

						- Ted
