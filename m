Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270138AbTGUOh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 10:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270120AbTGUOh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 10:37:27 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:16115 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S270138AbTGUOhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 10:37:25 -0400
Subject: Re: devfsd/2.6.0-test1
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, KML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20030721143645.GA9480@kroah.com>
References: <200307202117.32753.arvidjaar@mail.ru>
	 <1058741336.19817.147.camel@nosferatu.lan>
	 <20030721143645.GA9480@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1058799142.5132.5.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 21 Jul 2003 16:52:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-07-21 at 16:36, Greg KH wrote:
> On Mon, Jul 21, 2003 at 12:48:56AM +0200, Martin Schlemmer wrote:
> > On Sun, 2003-07-20 at 19:17, Andrey Borzenkov wrote:
> > > > Also, read the threads on the list about udev/hotplug - apparently
> > > > devfsd is going out ...
> > > 
> > > as long as you have memory-based /dev you need devfsd even if it is called 
> > > differently.
> > >
> > 
> > I have not looked at it myself, but as far as I have it, you do not
> > mount /dev, and just need udev/hotplug/libsysfs (not sure on libsysfs).
> > Currently udev still call mknod, but I think Greg said he will fix that
> > in the future.
> 
> What's wrong with calling mknod?
> 
> I did say I thought about calling sys_mknod directly from udev, but
> that's just a minor change.  Is that what you were referring to?
> 

Yep.  Nothing major - I just want to remember somebody moaning
about too much overhead with udev spawning for every event in
/dev.


Cheers,

-- 
Martin Schlemmer


