Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUF3TR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUF3TR4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 15:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUF3TRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 15:17:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23170 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261426AbUF3TQ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 15:16:58 -0400
Message-ID: <40E3119C.4060309@pobox.com>
Date: Wed, 30 Jun 2004 15:16:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Merwan Kashouty <kashouty@dakotainet.net>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm1,2,3 issues with sata and usb
References: <200406271122.41089.kashouty@dakotainet.net>
In-Reply-To: <200406271122.41089.kashouty@dakotainet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merwan Kashouty wrote:
> i am not having any luck from any of the mm releases above 2.6.7-rc3-mm2... 
> all kernels result in a kernel panic unable to open the root filesystem on 
> the via sata controller. i have successfully booted 2.6.7-bk1,2,3,4,5,6,7 ... 
> starting at 6 the drive changes from being seen as hdg to sdb as it should be 
> seen (i am using a asus-sk8v mainboard) since the sata driver is taking 
> controll of the device rather then the via-ide driver. 2.6.7-bk8 kernel 
> panics again unable to find the filesystem... bk9 and bk10 again work.
> i am not sure the source for the mm3 patch but it would appear to be bk8...lol
[...]
> both bk8 and mm1,2,3 pause for a terribly long time to determine the status of 
> the drives attached to the via-sata controller after which the kernel 
> eventually moves on to end in a panic. sometimes i get a usb error line just 
> after the panic then the system locks.
> 
> CC me if you can and i will be glad to provide anything further that i can or 
> test what ever you like to resolve/improve this.


Since you indicate that -bk9 and -bk10 work again, could you re-test and 
verify that more recent -mm releases work?  And also compare this 
against mainline -bk?

	Jeff


