Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVJIWsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVJIWsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 18:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVJIWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 18:48:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:6368 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932300AbVJIWsa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 18:48:30 -0400
Subject: Re: USB-> bluetooth adapter problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Luke Albers <gtg940r@mail.gatech.edu>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <43499A44.2070803@mail.gatech.edu>
References: <43499A44.2070803@mail.gatech.edu>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 00:48:43 +0200
Message-Id: <1128898123.19569.28.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luke,

> I have a 3com USB bluetooth adapter, that worked for  me at one time, 
> that I can't get working anymore.
> 
> The model is 3CREB96B
> 
> Sometimes it isnt even noticed when I plug it in, but after restarting 
> hotplug I get this:
> 
> usb 4-1: new full speed USB device using uhci_hcd and address 2
> hci_usb_probe: Can't set isoc interface settings
> usb 4-1: USB disconnect, address 2
> 
> I don't think that I have removed any options from the kernel that 
> should cause this, and other USB devices work fine.
> 
> Can someone please explain this message in more detail (google turns up 
> very little)?

try to load the hci_usb driver with "isoc=0". This disables the SCO
support inside the driver.

Regards

Marcel


