Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbTDWWcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbTDWWcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:32:07 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:62716 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S264262AbTDWWcG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:32:06 -0400
Message-ID: <3EA7172F.1050508@cox.net>
Date: Wed, 23 Apr 2003 17:43:59 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nils Holland <nils@ravishing.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [2.4.21-rc1] USB Trackball broken
References: <3EA6C558.5040004@cox.net> <20030423201619.GB12889@kroah.com> <3EA707D2.1000507@cox.net> <200304240034.20872.nils@ravishing.de>
In-Reply-To: <200304240034.20872.nils@ravishing.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nils Holland wrote:
> On Wednesday 23 April 2003 23:38, you wrote:
> 
> 
>>>If you do not build in the CONFIG_USB_EHCI driver, does it work ok?
>>
>>Nope. Same deal. Tried all 6 ports too. Attached is the dmesg and config.
> 
> 
> Strange. My trackball actually seems to be the very same as yours (Logitech 
> Cordless Trackman Optical). I'm also using a Logitech cordless keyboard, but 
> that's a different issue.
> 
> Anyway, here's my .config and dmesg with which this stuff is working just 
> fine:
;SNIP

By what my output is showing, I don't think the USB device is being 
registered with input correctly.
Your dmesg line:
input2: USB HID v1.10 Mouse [Logitech USB Receiver] on usb1:2.1
My dmesg line:
: USB HID v1.10 Mouse [Logitech USB Receiver] on usb2:4.0

I don't have the first field on mine.
Any ideas?

Thanks,
David

