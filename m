Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271796AbRH1QDD>; Tue, 28 Aug 2001 12:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271797AbRH1QCx>; Tue, 28 Aug 2001 12:02:53 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:11269 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S271796AbRH1QCp>;
	Tue, 28 Aug 2001 12:02:45 -0400
Date: Tue, 28 Aug 2001 09:01:26 -0700
From: Greg KH <greg@kroah.com>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB UHCI broken again w/ visor
Message-ID: <20010828090126.A7544@kroah.com>
In-Reply-To: <20010828013239.N16752@draal.physics.wisc.edu> <20010828083537.B7376@kroah.com> <20010828105330.S16752@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010828105330.S16752@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Tue, Aug 28, 2001 at 10:53:30AM -0500
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 10:53:30AM -0500, Bob McElrath wrote:
> 
> The behaviour of the usb-storage stuff is unchanged from 2.4.7, but the
> visor definitely did work with 2.4.7, where it doesn't now.

But the usb-storage code did change from 2.4.7-2.4.9 while the visor
code hasn't :)

So I'd try unloading the usb system (or rebooting if it's compiled into
the kernel), and just trying a visor sync without running the
usb-storage code to try to narrow down the potential problem.

thanks,

greg k-h
