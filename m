Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292283AbSBOXni>; Fri, 15 Feb 2002 18:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292284AbSBOXn0>; Fri, 15 Feb 2002 18:43:26 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:34575 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292283AbSBOXnK>;
	Fri, 15 Feb 2002 18:43:10 -0500
Date: Fri, 15 Feb 2002 15:38:49 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Patrick Mochel <mochel@osdl.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Small notes about /proc/driver
Message-ID: <20020215233849.GA4687@kroah.com>
In-Reply-To: <20020211204811.GA131@elf.ucw.cz> <Pine.LNX.4.33.0202131353100.25114-100000@segfault.osdlab.org> <20020213225227.GJ1454@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020213225227.GJ1454@elf.ucw.cz>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 18 Jan 2002 21:19:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 11:52:29PM +0100, Pavel Machek wrote:
> 
> That was joke. If you cat usb/something/name, it says 
> 
> "Should figure out some name"
> 
> . It really needs to be replaced with some better name.

Yes, that's the name I currently used for the different interfaces for a
device.  I've been focusing on getting this whole thing to work first :)

Now that all USB drivers have the ability to manipulate their inteface
directory, we can start flushing out what we want to put there...

thanks,

greg k-h
