Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284858AbRLKDZg>; Mon, 10 Dec 2001 22:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284850AbRLKDZ0>; Mon, 10 Dec 2001 22:25:26 -0500
Received: from mail317.mail.bellsouth.net ([205.152.58.177]:9553 "EHLO
	imf17bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S284854AbRLKDZX>; Mon, 10 Dec 2001 22:25:23 -0500
Message-ID: <3C157D8A.4090200@mindspring.com>
Date: Mon, 10 Dec 2001 22:29:14 -0500
From: Jonathan Stanford <jomast@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: USB + PCI - IRQ = kernel bug??
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got a problem usb subsystem......
it's not seeing anything past the root hub....
when a device is connected the following error pops up....

USB device not accepting new address=2 (error=-110)
see for yourself here --> http://quail.no-ip.com/bootmsg.txt

what i find interesting is that no interrupts are being sent
see for yourself here --> http://quail.no-ip.com/interrupts.txt

i've removed just about all devices from the system.... and there is no 
change....

here's a list of the PCI bus......
http://quail.no-ip.com/lspci.txt

this problem appears on everything from 2.4.7 (RH7.2 kern)  to the 
latest and greatest (2.4.17-pre8) and probably earlier kernels as well....

the southbridge/usb controler is the VIA Technologies, Inc. VT82C686b chip as you can see in 

http://quail.no-ip.com/lspci.txt


Let me know what else you need to make sence of this.......

-Jonathan Stanford
<jomast@mindspring.com>



