Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289609AbSAJTIt>; Thu, 10 Jan 2002 14:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289586AbSAJTIj>; Thu, 10 Jan 2002 14:08:39 -0500
Received: from daytona.gci.com ([205.140.80.57]:27148 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S289608AbSAJTI3>;
	Thu, 10 Jan 2002 14:08:29 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA315077C355F@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: Gunther Mayer <gunther.mayer@gmx.net>,
        Rene Engelhard <mail@rene-engelhard.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: RE: [PATCH] Getting ScanLogic USB-ATAPI Adapter to work
Date: Thu, 10 Jan 2002 10:08:21 -0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gunther.mayer.@.gmx.net writes:
> Rene Engelhard wrote:
> 
> > a long time ago I bought the Adapter mentioned above and got it
> > working.
> >
> I sent a fool-proof patch to the MAINTAINER 6 (nine!) months 
> before and discussed this on usb-devel. The MAINTAINER has chosen
> to reject this patch (for private discussions whith the manufacturer 
> about standards comliance) and leave users alone ! Although I proposed
> to him to disable all QUIRKS and Worksarounds for buggy hardware in his
> tree and see if the system still is running he stayed stubborn. As
> UNUSUAL_DEVS is quite large he is inconsequent for no apparent reason.
> 
> P.S. Please use this patch:
> - Don't bloat Config.in with with unnecessary decisions, just 
>   fix the bugger automatically.
> - Be non-intrusive to other devices.
> 
> Gunther

Gunther --

  Your patch is out of date.  But yesterday I posted practically the
same patch for the workaround using the current kernel defines. This patch
was tested across multiple platforms and devices and shown to work.
(caveat -- one cdrw is still having issues, but that is orthagonal to the
 patch)

Also, the unusual_devs.h  device definition will not work.  See my
patch for the multiple devices and their different requirements.
Your patch would break nearly everybody's equipment.

do not apply gunther's patch, please.

