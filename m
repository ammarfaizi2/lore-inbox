Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWINROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWINROK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 13:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWINROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 13:14:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:33753 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750798AbWINROJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 13:14:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1 (-mm2): ohci resume problem
Date: Thu, 14 Sep 2006 19:13:18 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Robert Hancock <hancockr@shaw.ca>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0609141202300.5715-100000@iolanthe.rowland.org> <200609141908.15991.rjw@sisk.pl>
In-Reply-To: <200609141908.15991.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141913.19492.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 14 September 2006 19:08, Rafael J. Wysocki wrote:
> On Thursday, 14 September 2006 18:17, Alan Stern wrote:
> > On Thu, 14 Sep 2006, Alan Stern wrote:
> > 
> > > Now of course, the autosuspend stuff has to work properly no matter what 
> > > the kernel configuration is.  I'll go back and rebuild the drivers with 
> > > USB_SUSPEND turned off and see what happens.  With any luck I'll have a 
> > > fix ready in the near future.
> > 
> > This should start fixing things, but I'm not certain it will solve the 
> > entire problem.  If it doesn't work, send another dmesg log.
> 
> Now USB didn't work after the first resume (kernel configured with USB_SUSPEND
> unset).

Okay, this is not reproducible, so I gather it was due to my other problem
with the USB resume (sigh).

Anyway, the second suspend/resume worked just fine, so the patch apparently
helps.

Thanks,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
