Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWBFNX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWBFNX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 08:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWBFNX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 08:23:57 -0500
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:4014 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S932088AbWBFNX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 08:23:57 -0500
Message-ID: <43E74DDB.7070508@mcmaster.ca>
Date: Mon, 06 Feb 2006 08:23:39 -0500
From: "Gabriel A. Devenyi" <devenyga@mcmaster.ca>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] USB HID fails to init USB keyboard
References: <mailman.1139192641.4990.linux-kernel2news@redhat.com> <20060205210211.675015ba.zaitcev@redhat.com>
In-Reply-To: <20060205210211.675015ba.zaitcev@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Sun, 5 Feb 2006 21:19:42 -0500, "Gabriel A. Devenyi" <devenyga@mcmaster.ca> wrote:
> 
>> usb 2-4: new low speed USB device using ohci_hcd and address 3
>> input: USB-compliant keyboard as /class/input/input2
>> input: USB HID v1.10 Keyboard [USB-compliant keyboard] on usb-0000:00:02.0-4
>> drivers/usb/input/hid-core.c: input irq status -32 received
> 
> The -32 is a stall, so it probably wants a NOGET quirk.
> 
> -- Pete
> 

Google tells me there's a blacklist to handle this, located in 
drivers/usb/input/hid-core.c, what info do I need to correctly add this 
keyboard/manufacturer to the blacklist?

--
Gabriel A. Devenyi
devenyga@mcmaster.ca
