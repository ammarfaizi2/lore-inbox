Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUBESk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 13:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266540AbUBESk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 13:40:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:26601 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266539AbUBESk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 13:40:56 -0500
Date: Thu, 5 Feb 2004 10:40:33 -0800
From: Greg KH <greg@kroah.com>
To: "Tillier, Fabian" <ftillier@infiniconsys.com>
Cc: "Hefty, Sean" <sean.hefty@intel.com>, linux-kernel@vger.kernel.org,
       Troy Benjegerdes <hozer@hozed.org>,
       "Woodruff, Robert J" <woody@co.intel.com>,
       "Magro, Bill" <bill.magro@intel.com>,
       "Woodruff, Robert J" <woody@jf.intel.com>,
       infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the Linux kernel
Message-ID: <20040205184033.GB13434@kroah.com>
References: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96A4@mercury.infiniconsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08628CA53C6CBA4ABAFB9E808A5214CB01DB96A4@mercury.infiniconsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 01:31:45PM -0500, Tillier, Fabian wrote:
> 
> Are you suggesting that if there is any abstraction, the code will never
> be accepted?  Or rather that the abstraction better be correct?  I'm
> hoping for the latter, however please clarify.

The kernel has its own abstractions that seem to be working quite well
for all different types of platforms.  There is no need for you to
create your own, just for a driver subsystem.

If you have found any problems with the current locks please let the
entire kernel community benefit from your changes, and not relegate them
to a infiniband-only section of the kernel.

So yes, if you add your own versions of spinlocks and atomic_t types,
your code will be rejected, among other things :)

thanks,

greg k-h
