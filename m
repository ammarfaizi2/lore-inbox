Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUD0TAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUD0TAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUD0TAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:00:55 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:34531 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S264277AbUD0TAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:00:53 -0400
From: Duncan Sands <baldrick@free.fr>
To: Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>
Subject: Re: Kernel Oops during usb usage (2.6.5)
Date: Tue, 27 Apr 2004 13:06:52 +0200
User-Agent: KMail/1.5.4
Cc: Bill Davidsen <davidsen@tmr.com>, "E. Oltmanns" <oltmanns@uni-bonn.de>,
       linux-kernel@vger.kernel.org
References: <20040423205617.GA1798@local> <200404270017.34478.oliver@neukum.org> <20040426223101.GA9258@kroah.com>
In-Reply-To: <20040426223101.GA9258@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404271306.52543.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Heh.  So the correct answer is:
> 	- don't do that.  Talking to the same device through usbfs at
> 	  the same time by multiple programs is cause for lots of bad
> 	  things to happen to your device, and might possibly cause it
> 	  to hang.  If you want to allow a user to access a device
> 	  through usbfs, make sure you trust them.

If usbfs fails to work when a device is accessed by multiple programs
then that is a bug in usbfs and should be fixed.  Hopefully it's already
fixed.

All the best,

Duncan.
