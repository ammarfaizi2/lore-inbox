Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUCJTIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbUCJTIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:08:53 -0500
Received: from mail.kroah.org ([65.200.24.183]:13784 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262774AbUCJTIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:08:50 -0500
Date: Wed, 10 Mar 2004 11:06:48 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Corey Minyard <minyard@acm.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, "Davis, Todd C" <todd.c.davis@intel.com>,
       sensors@stimpy.netroedge.com, "Simon G. Vogl" <simon@tk.uni-linz.ac.at>
Subject: Re: 2.6.4-rc2-mm1: IPMI_SMB doesnt compile
Message-ID: <20040310190648.GB18892@kroah.com>
References: <20040307223221.0f2db02e.akpm@osdl.org> <20040309013917.GH14833@fs.tum.de> <404F3BC3.2090906@acm.org> <20040310185105.GS14833@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310185105.GS14833@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 07:51:05PM +0100, Adrian Bunk wrote:
> On Wed, Mar 10, 2004 at 10:01:07AM -0600, Corey Minyard wrote:
> >...
> > I have included a patch from Todd Davis at Intel that adds this function 
> > to the I2C driver.  I believe Todd has been working on getting this in 
> > through the I2C driver writers, although the patch is fairly non-intrusive.
> > 
> > However, I have no real way to test this patch.
> >...
> 
> I can only confirm that it fixes the compilation...
> 
> 
> The patch to i2c-core.c is strange:

And dumb, and incorrect :(

thanks,

greg k-h
