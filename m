Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUAUI5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 03:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUAUI5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 03:57:23 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:20143 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S264129AbUAUI5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 03:57:22 -0500
Message-ID: <400E3FBF.8000100@stesmi.com>
Date: Wed, 21 Jan 2004 10:00:47 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hanasaki <hanasaki@hanaden.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6 - wrong identifcation of kt600 and usb 2.0 as 1.1
 - kernel issue? wrong mobo in the box? .....
References: <400E1EC5.5090809@hanaden.com>
In-Reply-To: <400E1EC5.5090809@hanaden.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I just bought the Soyo KT600 Dragon Ultra Platinum Edition
>     http://www.soyousa.com/products/proddesc.php?id=280
> The below lspci and dmesg output appears to be telling me that the 
> motherboard has:
>     REPORTED
>     ========
>     KT400
>     8 usb 1.1 ports
>     2 usb 2.0 ports
> 
>     IN THE MOTHERBOARD SPEC
>     =======================
>     KT600
>     8 usb 2.0 ports
>     0 usb 1.1 ports
> 
> I am not much of a kernel guru and know zero about USB.  Can someone 
> explain this to me?  Is it a kernel issue of misidentifying hardware? 
> Did someone put the wrong motherboard in the box?  I tried looking at 
> the kt600/kt400 chips under the fan/heatsink but the darn thing seems to 
> be glued onto the motherboard.

The fan/heatsink wasn't glued to my boards at least (I have two of
those). You just have to squeeze the plastic things on the back
of the board and it'll go off. I had a fan on mine. You?

All ports are USB 2.0. What you're missing is that you (afaik) use
UHCI to talk to USB 1.1 devices (1.5 and 12Mbit/s) and EHCI to talk
to USB 2.0 devices (up to 480Mbit/s). It should just work
out of the box. Try inserting a USB 2.0 device into each port and
see what it says. It works as USB 2 here with my Creative Zen NX
and I tried a few ports. THe only thing that isn't USB2 is the
card reader package that you got in the box. It's USB1.1 only.

// Stefan

