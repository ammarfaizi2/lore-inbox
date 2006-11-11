Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946875AbWKKBtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946875AbWKKBtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 20:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946876AbWKKBtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 20:49:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:43922 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1946875AbWKKBtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 20:49:36 -0500
Subject: Re: Fwd: [Suspend-devel] resume not working on acer ferrari 4005
	with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl, Christian.Hoffmann@wallstreetsystems.com
In-Reply-To: <200611110031.16173.rjw@sisk.pl>
References: <200611110031.16173.rjw@sisk.pl>
Content-Type: text/plain
Date: Sat, 11 Nov 2006 12:49:06 +1100
Message-Id: <1163209746.4982.203.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-11-11 at 00:31 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> We've just got the appended report.  Could you please have a look at this?

There are many possible reasons for that. The most likely is that the
BIOS isn't bringing the chip back on resume, causing radeonfb to
crash when trying to access it.

Ben.
 
> Greetings,
> Rafael
> 
> 
> ----------  Forwarded Message  ----------
> 
> Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
> Date: Friday, 10 November 2006 20:44
> From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
> To: suspend-devel@lists.sourceforge.net
> 
> Hello,
>  
> when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
> anymore. Screen stays black and nothing works anymore, no capslock light, no
> ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
> acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
>  
> You can see dmesg output and lspci -vv output here 
>  http://christianhoffmann.de/temp/radeon.log
>  http://christianhoffmann.de/temp/lspci.log
>  
> Thanks a lot for any input.
>  
> Chris
>  
> PS: I use kernel 2.18.1 + patch for radeonfb from
> http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view

