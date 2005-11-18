Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVKRXTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVKRXTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 18:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKRXTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 18:19:09 -0500
Received: from mail.kroah.org ([69.55.234.183]:29066 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751165AbVKRXTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 18:19:08 -0500
Date: Fri, 18 Nov 2005 15:03:23 -0800
From: Greg KH <greg@kroah.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Ian McDonald <imcdnzl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-ID: <20051118230323.GA25824@kroah.com>
References: <20051117111807.6d4b0535.akpm@osdl.org> <20051118203727.GA23151@kroah.com> <cbec11ac0511181314g7edaee33j47cbc6118228e49b@mail.gmail.com> <200511181816.01645.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511181816.01645.tomlins@cam.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 06:16:01PM -0500, Ed Tomlinson wrote:
> On Friday 18 November 2005 16:14, Ian McDonald wrote:
> > On 11/19/05, Greg KH <greg@kroah.com> wrote:
> > > Are you using debian?
> > > If so, what version of udev are you using?  There are some known
> > > reported problems with this, so I would suggest referring to the udev
> > > bug list.
> > >
> > In particular check the version requirements for udev - you need to be
> > on a version greater than or equal to 71. Sarge/stable has a really
> > old version. In particular I am running unstable as I had too many
> > funny errors (including this one) - but etch should be fine.
> > 
> > If running another distribution check this also as it is a real requirement.
> > 
> > To find the latest version of udev required check Documentation/Changes
> 
> devinfo -v 
> udevinfo, version 074 
> 
> dpkg -s 
> Package: udev
> Status: install ok installed
> Priority: extra
> Section: admin
> Installed-Size: 1072
> Maintainer: Marco d'Itri <md@linux.it>
> Architecture: amd64
> Version: 0.074-3
> 
> Interestingly the same udev works fine with 14-rc4-mm1.  I'll check the debian
> bugs.

Lots of things have changed in the input core since that kernel version.
Others have reported this same issue, see the thread from Ted Tso on
lkml a while ago when 2.6.15-rc1 came out.

thanks,

greg k-h
