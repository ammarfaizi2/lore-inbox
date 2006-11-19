Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756799AbWKSROk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799AbWKSROk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 12:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756801AbWKSROj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 12:14:39 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:20366 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1756799AbWKSROh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 12:14:37 -0500
Date: Sun, 19 Nov 2006 12:14:32 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: ohci1394 oops bisected [was Re: 2.6.19-rc5-mm2 (Oops in
 class_device_remove_attrs during nodemgr_remove_host)]
In-reply-to: <20061119162220.GA2536@inferi.kami.home>
To: linux-kernel@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       bcollins@debian.org
Message-id: <200611191214.32647.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <455CAE0F.1080502@s5r6.in-berlin.de>
 <455F7EDD.6060007@s5r6.in-berlin.de> <20061119162220.GA2536@inferi.kami.home>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 November 2006 11:22, Mattia Dongili wrote:
>On Sat, Nov 18, 2006 at 10:45:01PM +0100, Stefan Richter wrote:
>[...]
>
>> broken-out/gregkh-driver-config_sysfs_deprecated-bus.patch
>> broken-out/gregkh-driver-config_sysfs_deprecated-class.patch
>> broken-out/gregkh-driver-config_sysfs_deprecated-device.patch
>> broken-out/gregkh-driver-config_sysfs_deprecated-PHYSDEV.patch
>> broken-out/gregkh-driver-driver-link-sysfs-timing.patch
>> broken-out/gregkh-driver-sysfs-crash-debugging.patch
>> broken-out/gregkh-driver-udev-compatible-hack.patch
>
>Very close :) But no, the winner is...
>gregkh-driver-network-device.patch

If this has anything to do with kino segfaulting and going away when 
trying to make use of the on-screen camera motion controls, please see to 
it that it gets incorporated into the next FC6 kernel release, its badly 
needed for us ieee1394 users.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
