Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVH1VyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVH1VyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbVH1VyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:54:15 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:56525 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1750858AbVH1VyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:54:15 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Mattia Dongili <malattia@linux.it>
Subject: Re: Fw: Oops with 2.6.13-rc6-mm2 and USB mouse
Date: Sun, 28 Aug 2005 17:53:54 -0400
User-Agent: KMail/1.8.1
Cc: rbrito@ime.usp.br, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
References: <20050826220618.7365e690.akpm@osdl.org> <20050827200904.GA4362@ime.usp.br> <20050827203935.GJ5631@inferi.kami.home>
In-Reply-To: <20050827203935.GJ5631@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508281753.54881.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2005 16:39, Mattia Dongili wrote:
> On Sat, Aug 27, 2005 at 05:09:04PM -0300, Rog???rio Brito wrote:
> > Hi, Andrew.
> > 
> > I just tested the USB mouse with 2.6.13-rc6-mm2 and ACPI disabled
> > (which, according to Linus, is one of the "usual suspects") and the
> > problem still occurred.
> 
> see here
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112481438512222&w=2
> 
> Reverting driver-core-fix-bus_rescan_devices-race.patch and applying the
> patch attached to the above message fixed the oops for me.

I my case removing a usb device or hub triggers an immediate reboot with mm2.

This is fixed removing the above patch.  All is ok with mm1 too.  

I tried the above process but the second patch does not apply.  

Thanks
Ed Tomlinson
