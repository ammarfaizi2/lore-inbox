Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282503AbRKZU5x>; Mon, 26 Nov 2001 15:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282522AbRKZU4e>; Mon, 26 Nov 2001 15:56:34 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:25873 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S282503AbRKZUzK>;
	Mon, 26 Nov 2001 15:55:10 -0500
Date: Mon, 26 Nov 2001 13:51:42 -0800
From: Greg KH <greg@kroah.com>
To: "John D. Davis" <jddavis@triad.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problems with khub in current 2.4.15-2.4.16 kernels
Message-ID: <20011126135142.A4675@kroah.com>
In-Reply-To: <3C029D3F.E43B4E9C@triad.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C029D3F.E43B4E9C@triad.rr.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 29 Oct 2001 19:49:21 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 02:51:27PM -0500, John D. Davis wrote:
> I've noticed an odd occurance with the 2.4.15 and 2.4.16 kernels during
> testing.
> 
> There seems to be a problem with khub.c  or it could be my hardware but
> I keep getting the following oops and ptrace about 50% of the time
> during boot.  The following snip is from the boot log of the 2.4.16
> kernel compliled this afternoon.

Does this happen when you plug in your device after Linux is booted?
Can you send the output of /proc/bus/usb/devices with the device plugged
in (if it doesn't always cause an oops)?
Can you run that oops through ksymoops and post it?

thanks,

greg k-h
