Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129145AbQKMAvr>; Sun, 12 Nov 2000 19:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKMAvg>; Sun, 12 Nov 2000 19:51:36 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:42769 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129040AbQKMAv0>; Sun, 12 Nov 2000 19:51:26 -0500
Message-ID: <3A0F3B08.8C218DA4@holly-springs.nc.us>
Date: Sun, 12 Nov 2000 19:51:20 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: latest 2.2.18-X patch?
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDCBE@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone!

I've discovered that it works with my USB scanner, but the IBMCAM
doesn't work at all with the usb-uhci driver. It works once with the
uhci driver. Subsequent access using xawtv causes instantaneous lock-up.
No oops, nothing. Just freezes the entire system. Not even the keyboard
responds (can't toggle capslock, etc). Needless to say, magic sysrq
didn't work.

I've got another machine; I'll see if I can get a serial port dump to
report.

This was with 2.2.17 + pre-patch-2.2.18-21 on an Athlon 600.


-M

"Dunlap, Randy" wrote:
> 
> ftp.??.kernel.org/pub/linux/kernel/v2.2
> for linux-2.2.17.tar.{gz,bz2}
> and then ftp.??.kernel.org.pub/linux/kernel/people/alan/2.2.18pre
> for pre-patch-2.2.18-21.{gz,bz2}
> 
> Yes (USB backport).
> 
> ~Randy_________________________________________
> |randy.dunlap_at_intel.com        503-677-5408|
> |NOTE: Any views presented here are mine alone|
> |& may not represent the views of my employer.|
> -----------------------------------------------
> 
> > From: Michael Rothwell [mailto:rothwell@holly-springs.nc.us]
> >
> > Where's the best place to get the latest 2.2.18 kernel? And does it
> > include the USB backport?
> > -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
