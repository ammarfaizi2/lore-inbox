Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTIHQN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 12:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTIHQNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 12:13:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:7634 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262942AbTIHQMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 12:12:42 -0400
Date: Mon, 8 Sep 2003 09:06:31 -0700
From: Greg KH <greg@kroah.com>
To: Jamie Lokier <jamie@shareable.org>, David Brownell <david-b@pacbell.net>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB modem no longer detected in -test4
Message-ID: <20030908160631.GC10969@kroah.com>
References: <20030903191701.GA2798@elf.ucw.cz> <20030903223936.GA7418@kroah.com> <20030903224412.GA6822@atrey.karlin.mff.cuni.cz> <20030903233602.GA1416@kroah.com> <20030904212417.GF31590@mail.jlokier.co.uk> <3F57C951.8030606@pacbell.net> <20030906160200.GA10723@mail.jlokier.co.uk> <20030906174418.GA22620@kroah.com> <20030908062028.GJ19041@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908062028.GJ19041@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 11:20:28PM -0700, Mike Fedyk wrote:
> On Sat, Sep 06, 2003 at 10:44:18AM -0700, Greg KH wrote:
> > On Sat, Sep 06, 2003 at 05:02:00PM +0100, Jamie Lokier wrote:
> > > 
> > > So many other things don't work automatically for me in 2.6 that one
> > > little echo for cdc_acm is a little thing.  Besides, hotplug doesn't
> > > work either - something about the arguments to /sbin/hotplug has
> > > changed since 2.4 and I am in no rush to install a new version.
> > 
> > Sorry, but if you want hotplug to work in 2.6, you will have to install
> > a new version due to some changes to the network arguments, and due to a
> > bug in the older versions of the scripts.
> 
> What release date should the hotplug scripts be?  I still have that hotplug
> related oops that I told you about a while ago...

Try the latest :)

But that oops should have nothing to do with the scripts, that's a
kernel oops that I could never duplicate :(

thanks,

greg k-h
