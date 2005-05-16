Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVEPTRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVEPTRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 15:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVEPTRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 15:17:10 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:14101 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261773AbVEPTLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 15:11:45 -0400
Date: Mon, 16 May 2005 12:11:41 -0700
From: Greg KH <gregkh@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050516191141.GA10668@suse.de>
References: <20050506212227.GA24066@kroah.com> <4286839A.2090302@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4286839A.2090302@tls.msk.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 03:02:50AM +0400, Michael Tokarev wrote:
> Greg KH wrote:
> []
> >Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> >USB hotplug program can be written with a simple one line shell script:
> >	modprobe $MODALIAS
> 
> Speaking of which.. may I suggest this:
> 
>   if [ ! -L /sys/$DEVPATH/driver ]; then
>      modprobe $MODALIAS
>   fi

Sure, go ahead and make my script triple in lines :)

But yes, that would work just fine also.  I was just trying to show the
simplicity that is now available to us.

thanks,

greg k-h
