Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271805AbRH1QTn>; Tue, 28 Aug 2001 12:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271806AbRH1QTd>; Tue, 28 Aug 2001 12:19:33 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:13829 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271805AbRH1QT0>;
	Tue, 28 Aug 2001 12:19:26 -0400
Date: Tue, 28 Aug 2001 09:18:08 -0700
From: Greg KH <greg@kroah.com>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828091808.A7679@kroah.com>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu> <20010828083537.B7376@kroah.com> <20010828105330.S16752@draal.physics.wisc.edu> <20010828090126.A7544@kroah.com> <20010828110846.T16752@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010828110846.T16752@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Tue, Aug 28, 2001 at 11:08:46AM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 11:08:46AM -0500, Bob McElrath wrote:
> 
> I tried the visor first, and saw this behavior.  (without even insmoding
> the usb-storage driver)  I tried it several times, with the same
> results.  Only this morning before sending my message did I try the
> usb-storage to see if it was broken too.

And usb-storage worked?
Maybe it's a problem in your visor.  Does a soft reset of it fix it?

> Maybe related:
> Why would /proc/bus/usb be always empty?

Did you mount usbdevfs there?  See http://www.linux-usb.org/FAQ.html#gs3

thanks,

greg k-h
