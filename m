Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTEVWdo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 18:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTEVWdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 18:33:44 -0400
Received: from granite.he.net ([216.218.226.66]:785 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263353AbTEVWdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 18:33:42 -0400
Date: Thu, 22 May 2003 15:48:40 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI changes for 2.5.69
Message-ID: <20030522224840.GA7244@kroah.com>
References: <20030522220251.GA6814@kroah.com> <10536411591193@kroah.com> <20030522223616.GA5830@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030522223616.GA5830@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 11:36:16PM +0100, Dave Jones wrote:
> On Thu, May 22, 2003 at 03:05:59PM -0700, Greg KH wrote:
> 
>  > One may write new PCI device IDs into the new_id file:
>  > echo "8086 1229" > new_id
>  > 
>  > which will cause a new device ID (sysfs name 0) to be added to the driver.
> 
> Why not call the probe routine at this point ?
> This would do away with the need for the probe_it file.
> The only downside I can see is that if we have a script
> echoing lots of device id updates, we're going to lots of
> additional (-ENODEV) probes.

Keep reading through the patches :)

greg k-h
