Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVLaATd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVLaATd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 19:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLaATL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 19:19:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:17644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751083AbVLaATH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 19:19:07 -0500
Date: Fri, 30 Dec 2005 16:08:58 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 11 of 20] ipath - core driver, part 4 of 4
Message-ID: <20051231000858.GA20314@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com> <20051230081218.GB7438@kroah.com> <1135984675.13318.58.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135984675.13318.58.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2005 at 03:17:55PM -0800, Bryan O'Sullivan wrote:
> On Fri, 2005-12-30 at 00:12 -0800, Greg KH wrote:
> > And does your driver work with udev?  I didn't see where you were
> > exporting the major:minor number of your devices to sysfs, but I might
> > have missed it.
> 
> It was written in a pre-udev world, so it still uses a fixed major and
> minor number.  How important is this to you?  Is it "nice to have", or
> "blocker"? :-)

Well, depends on if you want your driver to work with any of the major
distros that rely on udev (RHEL, SLES, etc...)  If not, fine, you don't
need it :)

thanks,

greg k-h
