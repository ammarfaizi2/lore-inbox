Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280332AbRKJANd>; Fri, 9 Nov 2001 19:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280328AbRKJANX>; Fri, 9 Nov 2001 19:13:23 -0500
Received: from omnis-mail.omnis.com ([216.239.128.28]:8452 "HELO omnis.com")
	by vger.kernel.org with SMTP id <S280332AbRKJANQ>;
	Fri, 9 Nov 2001 19:13:16 -0500
Message-ID: <3BEC7180.5010908@sh.nu>
Date: Fri, 09 Nov 2001 16:14:56 -0800
From: Daniel Ceregatti <vi@sh.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011010
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Greg KH <greg@kroah.com>
Subject: Re: MS Natural keyboard extra keys using usb
In-Reply-To: <3BEC3B3A.6040005@sh.nu> <20011109170008.A10527@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a snippet from lsmod:

keybdev                 1728   0  (unused)

If I remove that module, the keyboard ceases to function. I have to ssh 
in and re-insert it. I have no idea why it says unused.

The module is loaded explicitly in rc.sysinit (Redhat 7.1)

2.4.9, the kernel where these keys work, uses the same driver.

Daniel

Greg KH wrote:

>On Fri, Nov 09, 2001 at 12:23:22PM -0800, Daniel Ceregatti wrote:
>
>>Ever since 2.4.10, these keys have stopped working.
>>
>
>Are you sure you are still using the HID keyboard drivers, and not the
>usbkbd (boot protocol keyboard) driver?
>
>thanks,
>
>greg k-h
>


