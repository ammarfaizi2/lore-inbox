Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTILVU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbTILVU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:20:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:49122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261918AbTILVUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:20:14 -0400
Message-Id: <200309122120.h8CLKCj26347@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Greg KH <greg@kroah.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, cliffw@easystreet.com
Subject: Re: 2.6.0-test5 usbserial oops 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Wed, 10 Sep 2003 21:46:50 PDT." <20030911044650.GA10064@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Sep 2003 14:20:12 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Sep 10, 2003 at 10:30:55PM -0500, Greg Norris wrote:
> > I'm seeing a consistent oops with usbserial under 2.6.0-test5, which
> > occurs when I try to sync my pda using pilot-link.  The module seems to
> > load (via hotplug) without any difficulty, and the sync itself works
> > fine... the oops occurs when the module is unloaded.  Once this
> > happens, it requires a reboot to get usb working again.
> > 
> > I've attached the decoded oops, along with my kernel .config.  If I
> > need to provide any additional information, please let me know.
> 
> Can you load both the usbserial and visor modules with "debug=1":
> 	modprobe usbserial debug=1
> 	modprobe visor debug=1
> 
> and then sync and remove the visor driver?
> I'd be very interested in the kernel debug log right up to the kernel
> oops.

I am also seeing an oops, 2.6.0-test5-mm1, Sony CLIE PDA. 
I'll try to get you the kernel debug tonight.
cliffw

> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


