Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbTCXW2j>; Mon, 24 Mar 2003 17:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264490AbTCXW2j>; Mon, 24 Mar 2003 17:28:39 -0500
Received: from lakemtao04.cox.net ([68.1.17.241]:48067 "EHLO
	lakemtao04.cox.net") by vger.kernel.org with ESMTP
	id <S264489AbTCXW2i>; Mon, 24 Mar 2003 17:28:38 -0500
Message-ID: <3E7F8993.7090807@cox.net>
Date: Mon, 24 Mar 2003 16:41:23 -0600
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 495] New: Logitech USB cordless optical trackball no longer
 works
References: <541570000.1048539830@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> http://bugme.osdl.org/show_bug.cgi?id=495
> 
>            Summary: Logitech USB cordless optical trackball no longer works
>     Kernel Version: 2.5.65-bk4
>             Status: NEW
>           Severity: high
>              Owner: greg@kroah.com
>          Submitter: davidvh@cox.net
> 
> 
> Distribution:
> 
> RedHat 8.0
> 
> Hardware Environment:
> 
> Asus P4S8X motherboard w/ Northwood Pentium 4 2.53GHz
> Logitech USB cordless optical trackball
> 
> Software Environment:
> 
> N/A
> 
> Problem Description:
> 
> Since 2.5.64, my trackball is no longer working.
> On bootup, a single message about a new USB device being found is displayed, but
> the typical HID input response never appears and the trackball doesn't work.
> I get the below message later:
> drivers/usb/core/message.c: usb_control/bulk_msg: timeout
> 
> Steps to reproduce:
> 
> Never works.

I just now figured out what the exact problem is.
It was fixed by changing the ACPI option for Enumeration to yes.
I'm assuming that there is a conflict between ACPI and USB.
That is all that I changed.

Regards,
David

