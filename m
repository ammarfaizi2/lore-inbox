Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTH0QLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTH0QK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:10:28 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:22510 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S263610AbTH0QJU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:09:20 -0400
Message-ID: <3F4CD7FC.4040309@basmevissen.nl>
Date: Wed, 27 Aug 2003 18:10:36 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to ruin your hardware(?)
References: <200308271511.h7RFBFHu017520@wildsau.idv.uni.linz.at>
In-Reply-To: <200308271511.h7RFBFHu017520@wildsau.idv.uni.linz.at>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H.Rosmanith (Kernel Mailing List) wrote:
>>>
> okidok.... I got an new flashdisk from the vendor, but managed to ruin
> it again. anyway, I also managed to repair it again. the vendor ships
> a seperate formating-tool, which will repair the device, even when you
> get "SCSI sense key errors".
> 

Q for the specialists: What SCSI access can still work then? I'm 
wondering if you can still write something to it. My first guess about 
that vender tool was that it just writes a valid partition table to the 
disk. The only problem is that you need to deduce the actual size of the 
flashdisk. But that can be retrieved from some USB identification string.

But it's more likely that it just uses some propriety interface to reset 
the device.

> however, I still don't understand what's going on and *why* it is not
> allowed to format the drive "at will". I'd also would like to know how
> this vendor supplied formating-tool works. Possibly some vendor-specific
> usb-commands to ... do what? hm. I can only guess.
> 

You can use USB Snoopy <http://www.wingmanteam.com/usbsnoopy/> to find 
out what that vendor tool (for Windows, I presume) does.

Bas.


