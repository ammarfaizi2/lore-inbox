Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUJRUti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUJRUti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267353AbUJRUtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:49:09 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:36779 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267327AbUJRUr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:47:58 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Richard Smith <rsmith@bitworks.com>
Date: Mon, 18 Oct 2004 13:47:45 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4173C981.13925.11BDE111@localhost>
In-reply-to: <417428F2.2050402@bitworks.com>
References: <4173B865.26539.117B09BD@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Smith <rsmith@bitworks.com> wrote:

> Kendall Bennett wrote:
> 
> > I would assume however a serial port console would be fine for embedded 
> > machines until the framebuffer driver could come up anyway.
> 
> This would be an incorrect assumption.  Speaking as a developer of
> one said embedded system I must have video at boot and be able to
> dump critical kernel messages to the screen. 
> 
> In the field, hooking up a serial cable to see why the unit
> doesn't boot requires the dispatch of a tech who would have open
> up the unit to get to the serial port.  This costs the end client
> lots of $$.  They don't like that. 
> 
> By having video on boot the support person can tell the end user
> to look at the screen and read back any messages and then make the
> determination if a tech dispatch is needed. 
> 
> And its common practice to only have as many serial ports as the
> system needs during runtime.  During development you can dual
> purpose them but in the final system their may not be a serial
> port free (or even installed) to get that console info from. 

Good, so my assumption was incorrect which I am happy about. Since it 
makes the work we did more useful ;-)

Anyway in your case do you need diagnostic messages just from the kernel 
or from the firmware as well? To get it in the firmware the video boot 
code would need to be ported there (U-Boot has a version of it already, 
but it is the only firmware I am aware of that supports this).

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


