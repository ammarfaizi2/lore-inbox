Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVBADXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVBADXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 22:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVBADXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 22:23:53 -0500
Received: from out010pub.verizon.net ([206.46.170.133]:11233 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261516AbVBADXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 22:23:51 -0500
Message-ID: <41FEF47A.60403@cwazy.co.uk>
Date: Mon, 31 Jan 2005 22:16:10 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hihone@bigpond.net.au
CC: linux <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc2-mm2 (& bk9) - rowdy little warn in drivers/usb/input/hid-input.c
References: <41FEC141.2060101@bigpond.net.au>
In-Reply-To: <41FEC141.2060101@bigpond.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [70.16.225.90] at Mon, 31 Jan 2005 21:16:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal wrote:
> With 2.6.11-rc2-mm2 & 2.6.11-rc2-bk9 and usb mouse, the warn("event 
> field not found") in drivers/usb/input/hid-input.c is hyperactive 
> whenever the mouse moves.
> 
> hihone kernel: drivers/usb/input/hid-input.c: event field not found
> hihone last message repeated 619 times
> hihone last message repeated 919 times
> hihone last message repeated 1325 times
> hihone last message repeated 1045 times
> 
> On the deviant case, both type and code appear to have the value 4 (if 
> that helps).  The mouse reports as
> hihone kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft 
> IntelliMouse<AE> Optical] on usb-0000:00:07.2-2
> 
> cheers, Cal
> (not subscribed, pls cc if needed)
> 
> 

I'm seeing the same thing on 2.6.11-rc2-mm2 with a Logitech USB mouse - every time 
the mouse moves, it throws these messages.

Jim
