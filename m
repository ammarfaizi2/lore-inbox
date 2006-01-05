Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWAEAky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWAEAky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWAEAky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:40:54 -0500
Received: from mail1.kontent.de ([81.88.34.36]:32999 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1750896AbWAEAkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:40:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <gregkh@suse.de>
Subject: Re: Clock going way too fast on 2.6.15 for amd64 processor
Date: Thu, 5 Jan 2006 01:40:44 +0100
User-Agent: KMail/1.8
Cc: ak@suse.de, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20060104233919.GA15724@kroah.com> <200601050054.45824.oliver@neukum.org> <20060105002818.GA9019@suse.de>
In-Reply-To: <20060105002818.GA9019@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601050140.45340.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 5. Januar 2006 01:28 schrieb Greg KH:
> On Thu, Jan 05, 2006 at 12:54:45AM +0100, Oliver Neukum wrote:
> > Am Donnerstag, 5. Januar 2006 00:39 schrieb Greg KH:
> > > Hi,
> > > 
> > > I tried digging through the mess in
> > > 	http://bugzilla.kernel.org/show_bug.cgi?id=3927
> > > but got lost in a see of conflicting patches.
> > > 
> > > I too have a amd64 box that is showing that the clock is running way too
> > > fast (feels about double speed, haven't checked for sure.)  I'm running
> > > it in 32bit mode for now, and the boot dmesg is below.
> > > 
> > > Any hints on patches that I should test out to try to track this down?
> > > I haven't run any real old kernels on it to see if it is something new
> > > (shows up on a 2.6.13 and 2.6.14 kernel too.)
> > 
> > Did you try "disable_timer_pin_1" on the kernel command line?
> 
> Nice, that worked just fine, no kernel patch needed.  Thanks for
> pointing it out to me, I totally missed it.
> 
> Now to go fix the usb irq "ignore" issue for this machine, and I'll be
> able to switch to using it all the time...

My machine which needs this is basically useless without ACPI.

	HTH
		Oliver
