Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUDBQ77 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 11:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbUDBQ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 11:59:59 -0500
Received: from mail.kroah.org ([65.200.24.183]:11155 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264108AbUDBQ76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 11:59:58 -0500
Date: Fri, 2 Apr 2004 08:59:41 -0800
From: Greg KH <greg@kroah.com>
To: Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.4: disabling SCSI support not possible
Message-ID: <20040402165941.GA29046@kroah.com>
References: <406D65FE.9090001@broadnet-mediascape.de> <6uad1uv7kr.fsf@zork.zork.net> <20040402144216.A12306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040402144216.A12306@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 02:42:17PM +0100, Russell King wrote:
> On Fri, Apr 02, 2004 at 02:21:40PM +0100, Sean Neakums wrote:
> > Olaf Zaplinski <o.zaplinski@broadnet-mediascape.de> writes:
> > 
> > > I cannot disable SCSI completely in 2.6.4's 'menuconfig'.
> > 
> > I believe that some kernel components require SCSI to be useful and so
> > force SCSI to be activated.  One example that springs to mind is
> > usb-storage.
> 
> usb-storage should depend on SCSI rather than forcing SCSI to be
> enabled.

No, this is the way it used to be, and it caused all kinds of problems
in the past.  It was switched to use 'select' on purpose, and should
stay that way.

thanks,

greg k-h
