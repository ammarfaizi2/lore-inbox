Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLLVJt>; Tue, 12 Dec 2000 16:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129659AbQLLVJj>; Tue, 12 Dec 2000 16:09:39 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:63632 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129391AbQLLVJb>; Tue, 12 Dec 2000 16:09:31 -0500
Date: Tue, 12 Dec 2000 15:38:53 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Greg KH <greg@wirex.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to capture long oops w/o having second machine
In-Reply-To: <20001212083812.A9287@wirex.com>
Message-ID: <Pine.LNX.4.30.0012121536510.1461-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope, this didn't fly. Would have been neat if it did work. Maybe it can
be made to work for future use?

On Tue, 12 Dec 2000, Greg KH wrote:

> I don't know if /dev/ttyUSBX would work, but I think it would.  People
> have successfully run consoles through the usb-serial drivers, but I'm
> not sure if the oops main console requires something different (like
> registering itself actually as a console?)
>
> And then there's the nice problem of the fact that if the oops comes
> from the USB code, you will not see it come out the usb-serial driver :)
>
> Let me know if you try this, and have any success (or find that it
> doesn't work.)

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
