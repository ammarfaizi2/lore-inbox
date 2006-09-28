Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWI1XqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWI1XqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWI1XqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:46:18 -0400
Received: from ns1.suse.de ([195.135.220.2]:33252 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750931AbWI1XqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:46:17 -0400
Date: Thu, 28 Sep 2006 16:46:18 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] More USB patches for 2.6.18
Message-ID: <20060928234618.GA17277@suse.de>
References: <20060928224250.GA23841@kroah.com> <Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281639040.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:40:23PM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 28 Sep 2006, Greg KH wrote:
> >
> > Here are some more USB bugfixes and device ids 2.6.18.  They should all
> > fix the reported problems in your current tree (if not, please let me
> > know.)
> > 
> > All of these changes have been in the -mm tree for a while.
> 
> Maybe I shouldn't have hurried you.
> 
> 	In file included from drivers/usb/host/ohci-hcd.c:140:
> 	drivers/usb/host/ohci-hub.c: In function 'ohci_rh_resume':
> 	drivers/usb/host/ohci-hub.c:184: error: invalid storage class for function 'ohci_restart'
> 	drivers/usb/host/ohci-hub.c:188: warning: implicit declaration of function 'ohci_restart'
> 	drivers/usb/host/ohci-hcd.c: At top level:
> 	drivers/usb/host/ohci-hcd.c:815: error: static declaration of 'ohci_restart' follows non-static declaration
> 	drivers/usb/host/ohci-hub.c:188: error: previous implicit declaration of 'ohci_restart' was here
> 	make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> 	make[2]: *** [drivers/usb/host] Error 2
> 	make[1]: *** [drivers/usb] Error 2
> 	make: *** [drivers] Error 2
> 
> oops.

Odd, care to attach your .config?

thanks,

greg k-h
