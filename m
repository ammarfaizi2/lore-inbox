Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSGFRsg>; Sat, 6 Jul 2002 13:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSGFRsf>; Sat, 6 Jul 2002 13:48:35 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:57355 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S315634AbSGFRse>;
	Sat, 6 Jul 2002 13:48:34 -0400
Date: Sat, 6 Jul 2002 10:49:11 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net,
       Linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: only one USB UHCI driver in 2.5 now
Message-ID: <20020706174911.GB8257@kroah.com>
References: <20020706174345.GA8257@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020706174345.GA8257@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Sat, 08 Jun 2002 16:39:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Well, I've taken everyone's responses to my "choose a UHCI driver"
message, looked at the two drivers a bunch myself, and ran through all
of the devices I could throw at them.  As of 2.5.25, I've chosen the
"alternate" UHCI driver, uhci-hcd.o.  I'll delete the other HCD drivers
in the drivers/usb/host directory that are now no longer in the build,
and send that to Linus in a few days.

I'd like to publicly thank Georg Acher, Deti Fliegl, and Thomas Sailer
for all of the work they have put into the usb-uhci.c and usb-uhci-hcd.c
drivers in the past.  It has been greatly appreciated.

I'm not going to remove the usb-uhci.c driver in the 2.2 and 2.4
kernels, as they have proven to be stable there.

thanks,

greg k-h
