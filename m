Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSBXGzm>; Sun, 24 Feb 2002 01:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293293AbSBXGzc>; Sun, 24 Feb 2002 01:55:32 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:35588 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289806AbSBXGzZ>;
	Sun, 24 Feb 2002 01:55:25 -0500
Date: Sat, 23 Feb 2002 22:49:31 -0800
From: Greg KH <greg@kroah.com>
To: Dan Hopper <dbhopper@austin.rr.com>, Patrick Mochel <mochel@osdl.org>,
        Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.5.5-pre1 rmmod usb-uhci hangs
Message-ID: <20020224064931.GD15060@kroah.com>
In-Reply-To: <fa.n7cofbv.1him3j@ifi.uio.no> <fa.dsb79pv.on84ii@ifi.uio.no> <20020224025411.GA2418@yoda.dummynet> <20020224062124.GB15060@kroah.com> <20020224063915.GA2799@yoda.dummynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020224063915.GA2799@yoda.dummynet>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 27 Jan 2002 04:03:06 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 12:39:15AM -0600, Dan Hopper wrote:
> 
> The reason I'd like to switch back to usb-uhci instead of uhci is
> twfold:  Vmware seems to want to only use usb-uhci and not uhci
> (dummies!).  And uhci seems to be unable to get the scanner going
> such that it doesn't "stutter" all the way down the page.  usb-uhci
> seems to be able to keep up so that it just sweeps on down the page.

I noticed that Vmware does that, and was wondering why.

If you get a chance, can you try the uhci patches that were posted on
linux-usb-devel last week, or all of them rolled up at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/linux-2.4.18-rc2-gregkh-1.patch.gz
and let me know if that solves your problem with uhci or not?

thanks,

greg k-h
