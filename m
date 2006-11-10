Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946221AbWKJXdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946221AbWKJXdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946783AbWKJXdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:33:46 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:17592 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1946221AbWKJXdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:33:45 -0500
content-class: urn:content-classes:message
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Fwd: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Sat, 11 Nov 2006 00:31:15 +0100
User-Agent: KMail/1.9.1
Cc: linux-fbdev-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>, Christian@ogre.sisk.pl,
       Hoffmann@albercik.sisk.pl, Christian.Hoffmann@wallstreetsystems.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611110031.16173.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've just got the appended report.  Could you please have a look at this?

Greetings,
Rafael


----------  Forwarded Message  ----------

Subject: [Suspend-devel] resume not working on acer ferrari 4005 with radeonfb enabled
Date: Friday, 10 November 2006 20:44
From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
To: suspend-devel@lists.sourceforge.net

Hello,
 
when I have radeonfb enabled, my laptop (X700 ati mobility) doesnt resume
anymore. Screen stays black and nothing works anymore, no capslock light, no
ctrl alt sysreq b etc. I tried all kind of things vbetool, passing
acpi_sleep=s3_bios,s3_mode to the kernel. Nothing seems to work.
 
You can see dmesg output and lspci -vv output here 
 http://christianhoffmann.de/temp/radeon.log
 http://christianhoffmann.de/temp/lspci.log
 
Thanks a lot for any input.
 
Chris
 
PS: I use kernel 2.18.1 + patch for radeonfb from
http://bugzilla.kernel.org/attachment.cgi?id=9408&action=view
