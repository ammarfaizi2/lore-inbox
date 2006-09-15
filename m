Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWIOXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWIOXFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWIOXFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:05:33 -0400
Received: from mail.gibbons.com ([66.80.7.162]:12166 "EHLO gibbons.com")
	by vger.kernel.org with ESMTP id S932353AbWIOXFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:05:32 -0400
Message-ID: <450B31BF.4050604@gibbons.com>
Date: Fri, 15 Sep 2006 16:05:35 -0700
From: Jim Gibbons <jim@gibbons.com>
Reply-To: jim@gibbons.com
Organization: Gibbons and Associates, Inc.
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: request for ioctl range for private devices
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm involved in the construction of a Linux based device that needs to 
use ioctl's to communicate between its kernel module and its daemons.  
The device is an embedded product.  We should never have any need to 
distribute this driver interface.

I would like to use an ioctl range that would be safe, now and in the 
future.  Given that we won't be putting this driver on any general 
computing platforms, it seems inappropriate to reserve an ioctl range 
for this device.

I would really like to use an ioctl range that is reserved for the class 
of private embedded devices.  That way, I could be sure that I would 
never conflict with any peripheral that we might use without a 
reservation specific to our device.

Would you consider reserving space for such ioctl's?

p.s. I am not a kernel developer and hence not a member of this mailing 
list.  Please cc me on any replies.

p.p.s. I first sent this request to Michael Chastain, who remains listed 
in Documentation/ioctl-number.txt.  He replied that he is no longer 
involved and referred me to this e-mail list.  Perhaps that document 
should be updated.


