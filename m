Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUHVUoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUHVUoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUHVUoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:44:11 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:37863 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S266603AbUHVUoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:44:08 -0400
Message-ID: <41290606.10101@drzeus.cx>
Date: Sun, 22 Aug 2004 22:45:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: platform bus, usage?
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the process of writing a driver for a SD/MMC card reader. Since 
this is the first driver I'm writing I'm having some difficulties 
fitting it into the linux driver model. I've read all the documentation 
I can find to no avail.

The device is attached to the LPC bus and cannot be found using PNP. 
 From what I can gather this driver should therefore be organised under 
the platform bus. I can't figure out how to do this though. I've created 
the device structure, with platform_bus_type at .bus. I've called 
device_register with the structure. Now how to I create a device object 
and attach this to the bus? With PCI I guess this handles itself using 
the PCI id:s.

At the moment I just let the driver play by itself. But that doesn't 
seem to be using the driver model properly.

Any pointers would be helpful. Documentation, functions, example 
drivers, anything.

Rgds
Pierre Ossman

