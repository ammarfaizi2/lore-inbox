Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268179AbUH1Fal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268179AbUH1Fal (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUH1Fal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:30:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:56519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268179AbUH1Faj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:30:39 -0400
Date: Fri, 27 Aug 2004 22:30:12 -0700
From: Greg KH <greg@kroah.com>
To: lkml-mail@asthe.com, random-mail@LavaRnd.org
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Termination of the Philips Webcam Driver (pwc)
Message-ID: <20040828053012.GD10151@kroah.com>
References: <74c68b63c43337d4366c367b282f4b91916d61ff@asthe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c68b63c43337d4366c367b282f4b91916d61ff@asthe.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 07:16:18PM -0700, lkml-mail@asthe.com wrote:
> 
> We would be happy to discuss ways that the pwc might be maintained
> in the linux kernel.  If we can help, please ask us (see
> http://www.lavarnd.org/about-us/contact-us.html for our EMail address).

Great.  Here's what you can do.  Take the patch availble at:
	http://linux.bkbits.net:8080/linux-2.5/cset@412d8e0cqutBsdGubqorXXCeHHdS2g
and apply it reversed to your kernel tree (with -R as an option to
patch).  That patch has the binary hook already removed.

Then clean up the text a bit to point to you as the maintainer, that no
one should bother the original author anymore, and such.  Cleanup and
change anything else that you think needs to be done to the driver, and
then send me that patch as documented in the
Documentation/SubmittingPatches in the kernel tree.

Then you would be the new maintainer of the driver, and the code would
be back in the kernel tree.

Sound good?

thanks,

greg k-h
