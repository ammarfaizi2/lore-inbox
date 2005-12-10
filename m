Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbVLJXig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbVLJXig (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161070AbVLJXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 18:38:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:62404 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161067AbVLJXif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 18:38:35 -0500
Date: Sat, 10 Dec 2005 15:28:37 -0800
From: Greg KH <greg@kroah.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, torvalds@osdl.org, scjody@modernduck.com,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH] sbp2: fix panic when ejecting an ipod
Message-ID: <20051210232837.GE11094@kroah.com>
References: <20051209171922.GW19441@conscoop.ottawa.on.ca> <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
> sbp2: fix panic when ejecting an ipod
> 
> Sbp2 did not catch some bogus transfer directions in requests from upper
> layers.  Problem became apparent when iPods were to be ejected:
> http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
> http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435
> Debugging and original variant of the patch by Andrew de Quincey.
> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: Andrew de Quincey <adq@lidskialf.net>

Is this in linus's tree yet?  Do the 1394 maintainers accept it as a
valid fix?

thanks,

greg k-h
