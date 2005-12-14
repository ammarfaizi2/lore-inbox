Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964946AbVLNUq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964946AbVLNUq7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVLNUq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:46:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:37055 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964946AbVLNUq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:46:58 -0500
Date: Wed, 14 Dec 2005 12:38:59 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, torvalds@osdl.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [stable] [PATCH] sbp2: fix panic when ejecting an ipod
Message-ID: <20051214203859.GA568@kroah.com>
References: <20051209171922.GW19441@conscoop.ottawa.on.ca> <200512101125.jBABP7Z9001085@einhorn.in-berlin.de> <20051210232837.GE11094@kroah.com> <439B7A8F.6000209@s5r6.in-berlin.de> <43A07C05.90800@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A07C05.90800@s5r6.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 09:09:41PM +0100, Stefan Richter wrote:
> I wrote on 2005-12-11:
> >Greg KH wrote:
> >>On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
> >>>Sbp2 did not catch some bogus transfer directions in requests from upper
> >>>layers.
> ...
> >>Is this in linus's tree yet? 
> ...
> >>Do the 1394 maintainers accept it as a valid fix?
> ...
> >Jody posted a NAK a few hours ago:
> >|| NAK.  James has a patch to fix this in the SCSI layer, which is his
> >|| preference.
> 
> FYI, James' fix for sd_init_command etc. is this one:
> http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=c9526497cf03ee775c3a6f8ba62335735f98de7a
> 
> It depends on the following patch to apply cleanly (but does not 
> actually require it to work and fix the iPod related panic):
> http://www.kernel.org/git/?p=linux/kernel/git/jejb/scsi-rc-fixes-2.6.git;a=commit;h=a8c730e85e80734412f4f73ab28496a0e8b04a7b
> 
> Sorry for any confusion I might have created,

Ok, care to submit something to stable@ to get the fix into the next
2.6.14.y queue?

thanks,

greg k-h
