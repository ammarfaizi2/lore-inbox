Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbUJ0TYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUJ0TYF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUJ0TWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:22:30 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:10880 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S262522AbUJ0TRr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:17:47 -0400
Date: Wed, 27 Oct 2004 21:17:28 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Greg KH <greg@kroah.com>
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-mm1, class_simple_* and GPL addition
Message-ID: <20041027191728.GA6897@vana.vc.cvut.cz>
References: <20041027135052.GE32199@gamma.logic.tuwien.ac.at> <20041027153715.GB13991@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027153715.GB13991@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 08:37:16AM -0700, Greg KH wrote:
> On Wed, Oct 27, 2004 at 03:50:52PM +0200, Norbert Preining wrote:
> > Hi Andrew!
> > 
> > The change from 
> > 	EXPORT_SYMBOL
> > to
> > 	EXPORT_SYMBOL_GPL
> > for class_simple_* makes the nvidia module useless as it uses several:
> > nvidia: Unknown symbol class_simple_device_add
> > nvidia: Unknown symbol class_simple_destroy
> > nvidia: Unknown symbol class_simple_device_remove
> > nvidia: Unknown symbol class_simple_create
> 
> I think these changes are only in the Gentoo modified version of the
> driver, right?  I don't think that nvidia wrote the driver that way.

VMware's vmnet is broken by this too.  VMware was asked by RedHat to 
add udev compatibility to the code, and now you are saying that both
RedHat and VMware were wasting resources for nothing, as you decided that
you'll turn existing interface into GPL only without providing
alternative way?

> > and if yes, if there is a way to fix nvidia kernel modules (or others)
> > using this device management interface.
> 
> Get them to change the license on their code.

Why?  You have more rights to the sources now than with GPL,
why we should restrict ourself?
						Best regards,
							Petr Vandrovec


