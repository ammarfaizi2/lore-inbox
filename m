Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbUFQUXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUFQUXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbUFQUXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:23:39 -0400
Received: from mail.kroah.org ([65.200.24.183]:1975 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262425AbUFQUXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:23:30 -0400
Date: Thu, 17 Jun 2004 13:22:08 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@lst.de>, "Adam J. Richter" <adam@yggdrasil.com>,
       linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
Message-ID: <20040617202207.GB23533@kroah.com>
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com> <20040617180507.GA18134@kroah.com> <20040617195458.GA31338@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617195458.GA31338@lst.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 09:54:58PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 17, 2004 at 11:05:08AM -0700, Greg KH wrote:
> > On Thu, Jun 17, 2004 at 11:29:55PM -0700, Adam J. Richter wrote:
> > > 	I believe that Greg Kroah-Hartmann said that the changes
> > > should go into 2.5.  I'm still waiting, although I don't know if
> > > I even have a copy of the user level helper code anymore.
> > 
> > No one ever sent me patches to do this during the 2.5 development
> > series.  That's why nothing changed.
> 
> WAKE UP!
> 
> We have files in the kernel we can't distribute.

I do not agree with that statement.  Those files were placed in the
kernel tree in good faith that they could be redistributed.  I have the
email trails to prove it.  If the wording is somehow not correct to
convey this intent, I will be quite willing to fix it.

> We have a copyright holder in that particular area who told you to
> stop it.

I do not agree that this copyright holder has anything to do with the
code in that area at all.  I only see two named copyright holders on the
drivers/usb/serial/keyspan.c file:
    (C) Copyright (C) 2000-2001   Hugh Blemings <hugh@blemings.org>
    (C) Copyright (C) 2002        Greg Kroah-Hartman <greg@kroah.com>

Adam did submit a small patch to the file back in 11/01/2000, but as to
if that constitutes a multiple copyright of that file, I'll leave to the
IP lawyers to decide.

> I told you it's not okay and I'm a major kernel copyright holder to.

For the emi26 firmware image, yes, I agree the wording is not very
clear, but I have documentation that the original owner of the file gave
permission to have these files included in the kernel tree.  I will add
the proper wording from the keyspan firmware image to that file in my
tree and send it to Linus in the next series of USB patches.

As for the wording of the keyspan firmware images, I do not agree that
this is not allowed.  We have been over this many times in the past, and
I've had IP lawyers look at the current wording and implementation of
these files and they have given me their blessing that it is ok to do
so.

> Do Adam & me need to ask the vendors and mirrors to take the kernel
> tarball down first before you react?

Again, I am reacting to the emi26 image.  The keyspan dispute I do not
agree with.  We are free to disagree with each other here, but until I
receive a contrary legal opinion, I will insist that these files remain.

thanks,

greg k-h
