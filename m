Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTKZXhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbTKZXhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:37:42 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:36616
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264363AbTKZXhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:37:41 -0500
Date: Wed, 26 Nov 2003 15:37:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Vince <fuzzy77@free.fr>, Linux Kernel <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-ID: <20031126233738.GD1566@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Vince <fuzzy77@free.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com> <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com> <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 01:18:48PM -0500, Zwane Mwaikambo wrote:
> On Wed, 26 Nov 2003, Vince wrote:
> 
> > > *groan* do you have a PDA?
> > >
> >
> > Nope. I could probably borrow a laptop to a friend but am not excited at
> > the idea of having to setup some serial console thing (I do not even
> > have a serial cable). Dump to floppy/swap/disk would be much easier in
> > my case... if it could me made to work, of course ;-)
> 
> Those oopses looked rather spurious, i'm not sure what help those other
> methods would be here. Try applying the following patch and be sure to
> have access to the console. You may have to hand transcribe...

Interesting.  It would be nice to have a boot option that halts the system
after the first oops, instead of trying to continue.

Vince/Randy:
Did you use the 2.5.65 patch at http://w.ods.org/tools/kmsgdump/ or is there
some other place that has newer patches?

BTW, http://www.xenotime.net/linux/kmsgdump gives a 404 error.
