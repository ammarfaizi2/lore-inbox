Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbUKCV2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbUKCV2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 16:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbUKCV2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 16:28:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:51677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261895AbUKCVXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 16:23:34 -0500
Date: Wed, 3 Nov 2004 13:23:19 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: germano.barreiro@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041103212318.GA29830@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81C@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D81C@minimail.digi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 02:20:39PM -0600, Kilau, Scott wrote:
> > > Maybe we can allow a "custom" name to be sent into the
> > > tty_register_device() call?  Like add another option parameter
> called
> > > "custom_name" that if non-NULL, is used instead of the derived name?
> 
> > Why?  What would you call it that would be any different from what we
> > use today?  I guess I don't understand why you don't like the kernel
> > names.
> 
> > greg k-h
> 
> Well, tty name compatibly reasons with a couple of our drivers.
> 
> Most of our new Linux users for a couple of our older products are
> coming
> from a specific different OS who are adamant that we keep the tty names
> the way they were used to under that OS.
> 
> Also, I can see some oddball products out there that might need
> only 1 tty out there.
> 
> Instead of forcing "ttyoddball0" for the name, it would
> be nice to let the driver use "ttyoddball", or whatever it wanted.

Your driver can use whatever name you wanted, as long as it's the
LANNANA name that you asked for and were assigned.  We do have standards
for a good reason, and the kernel will follow them.

That being said, have your customers use a tool like udev.  Then they
can name their tty devices whatever they want.  No limitations there at
all.

Hope this helps,

greg k-h
