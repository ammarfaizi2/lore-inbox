Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422733AbWATCQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422733AbWATCQO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 21:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161264AbWATCQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 21:16:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47522
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161253AbWATCQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 21:16:13 -0500
Date: Thu, 19 Jan 2006 18:15:28 -0800
From: Greg KH <greg@kroah.com>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>, gregkh@suse.de
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
Message-ID: <20060120021528.GA19201@kroah.com>
References: <20060119194647.12213.44658.14543@lnx-maule.americas.sgi.com> <20060119194652.12213.96503.19247@lnx-maule.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119194652.12213.96503.19247@lnx-maule.americas.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:46:52PM -0600, Mark Maule wrote:
> Abstract portions of the MSI core for platforms that do not use standard
> APIC interrupt controllers.  This is implemented through a new arch-specific
> msi setup routine, and a set of msi ops which can be set on a per platform
> basis.
> 
> Signed-off-by: Mark Maule <maule@sgi.com>

Note that I changed this patch a bunch, rearanging where things went
(should not have touched include/linux/pci.h for this change) and
everything builds properly still on i386.  You should check that they
build on ia64 now too.

thanks,

greg k-h
