Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317443AbSHCBGl>; Fri, 2 Aug 2002 21:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317444AbSHCBGl>; Fri, 2 Aug 2002 21:06:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31244 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317443AbSHCBGl>;
	Fri, 2 Aug 2002 21:06:41 -0400
Message-ID: <3D4B2D72.80601@mandrakesoft.com>
Date: Fri, 02 Aug 2002 21:10:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hell.Surfers@cwctv.net
CC: linux-kernel@vger.kernel.org
Subject: Re: how do i integrate my winmodem driver.
References: <0ca6d3103010382DTVMAIL6@smtp.cwctv.net>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hell.Surfers@cwctv.net wrote:
> I need to know how support for winmodems is added as I am having trouble integrating support for the supra pci winmodem driver i am writing, but im not used to writing drivers for linux, ive written the interface though, im new to linux driver writing, please help!



Ideally, you can present it as a serial device, and put all the code in 
the kernel.  Look at other serial drivers in linux/drivers/char.  _Linux 
Device Drivers_ is a decent book, but doesn't cover the serial/tty 
interfaces IIRC.  Your best reference is always the kernel source code.

To actually submit a driver, read Documentation/SubmittingDrivers and 
Documentation/SubmittingPatches.

	Jeff


P.S. Fix your word wrap :)


