Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271597AbRH1PhL>; Tue, 28 Aug 2001 11:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271613AbRH1PhB>; Tue, 28 Aug 2001 11:37:01 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:7429 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271597AbRH1Pgz>;
	Tue, 28 Aug 2001 11:36:55 -0400
Date: Tue, 28 Aug 2001 08:35:37 -0700
From: Greg KH <greg@kroah.com>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828083537.B7376@kroah.com>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Tue, Aug 28, 2001 at 01:32:40AM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 01:32:40AM -0500, Bob McElrath wrote:
> USB verbose debug is ON, using driver usb-uhci, on an alpha, kernel
> 2.4.9, new batteries in the thing.  This worked with 2.4.7.  What
> happened?  It seems like every other kernel version it gets broken
> again, and I can't sync my visor.

It looks like your uhci controller is not getting interrupts anymore.
Does the value of /proc/interrupts for the usb-uhci driver get
incremented?

Does any other usb devices work on this system?

thanks,

greg k-h
