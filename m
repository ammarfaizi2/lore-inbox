Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312413AbSDNSwj>; Sun, 14 Apr 2002 14:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312414AbSDNSwi>; Sun, 14 Apr 2002 14:52:38 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:27146 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312413AbSDNSwh>;
	Sun, 14 Apr 2002 14:52:37 -0400
Date: Sun, 14 Apr 2002 10:52:17 -0700
From: Greg KH <greg@kroah.com>
To: Ian Molton <spyro@armlinux.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-uhci *BUG*
Message-ID: <20020414175217.GB18040@kroah.com>
In-Reply-To: <20020414004022.6450f038.spyro@armlinux.org> <20020414150719.GA17826@kroah.com> <20020414183247.016a2ec3.spyro@armlinux.org> <20020414164355.GA18040@kroah.com> <20020414192532.65afcfae.spyro@armlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 14:36:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 07:25:32PM +0100, Ian Molton wrote:
> Greg KH Awoke this dragon, who will now respond:
> 
> > On Sun, Apr 14, 2002 at 06:32:47PM +0100, Ian Molton wrote:
> > > 
> > > > What devices do you have plugged in?
> > > 
> > > one alcatel usb speedtouch ADSL modem, using the 'user mode' driver.
> > 
> > Ah, please try using the patch below from David Brownell to fix this
> > problem.  I've already applied this to my trees, and will get pushed to
> > the main kernels soon.
> > 
> > Let me know if this helps or not.
> 
> apparently not. first time it booted, it oopsed (not recorded, sorry).
> second time, it hit the BUG() again. same backtrace.

Is this before you even run the usermode driver?

A real ksymoops output would be appreciated.

thanks,

greg k-h
