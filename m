Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263737AbUDGQqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbUDGQqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:46:55 -0400
Received: from iris2.directnic.com ([204.251.10.82]:47036 "HELO
	iris2.directnic.com") by vger.kernel.org with SMTP id S263737AbUDGQqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:46:47 -0400
X-Envelope-Sender: roy@royfranz.com
X-Envelope-Recipient: linux-kernel@vger.kernel.org
Message-ID: <40743064.1030106@royfranz.com>
Date: Wed, 07 Apr 2004 09:46:28 -0700
From: Roy Franz <roy@royfranz.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: probable Linux Kernel GPL violation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

    I have encountered a vendor that is selling a device that
admittedly contains a modified Linux kernel, and they refuse to provide
the source for the modified kernel.  They claim that the GPL does not
apply to those changes.  They do not seem to be using modules.  I don't
know how to pursue this further, so I am bringing it to the attention of
the kernel developers.

The product in question is the Tritton Technologies NAS120.
(They also offer version with router functionality that is based on the
same board.)  This board is based on the Toshiba TX39 processor (MIPS),
and has a realtek ethernet chip on it.  It is running kernel
version 2.4.16.

See:
http://www.trittontechnologies.com/products.html

This is clearly made by mct.com.tw:
http://www.mct.com.tw/prod/sa-100.html
As some files in the image identify it as such.

Several other vendors also sell versions of this.
http://www.iogear.com/main.php?loc=product&product_id=645
http://www.claxan.ch/de/prod_det.asp?PRODID=CL-SA110&TOPNAVID=-1
(claxan offers download of some source code, but not the kernel.  A
Customer of theirs contacted them and they also refuse to release kernel
source.)

Here is the response from Tritton stating that they will not release the
modified kernel source.  This was after several email exchanges where I
was being very clear that I was interested in the kernel source.


> Sir,
> 
> Earlier I stated that the kernal would be included with the package. While this
> is still true, you must know that the modifications made to the kernal will not
> be included. This is because of two things: 1) Those mods do not fall under the
> GPL and 2) They are owned by Toshiba.
> 
> Sorry for the confusion,
> 
> --
> Tritton Tech Support
> NEW! GET LIVE HELP ONLINE! http://support.trittontechnologies.com

The response from Claxan was (from an owner of a claxan device):
>>
>> amadeo@no.spam wrote:
>>
>>> Hello Roy
>>> I get an answer from the local distributor of "our" device:
>>> The Linux-Kernel ist an own developement from the manufacturer and therefore not under the GNU-License. This is the reason why they don't publish the code.
>>> I'm sorry, that I can't send you better informations.
>>> regards
>>> Amadeo
>>
>>


If you would like to look at the firmware yourself, you can download it
from:
http://www.claxan.ch/de/prod_det-driver.asp?TOPNAVID=-1
or
http://support.trittontechnologies.com/downloads.html

See http://www.royfranz.com/Hacking_the_Tritton_NAS120.html for more
info on what is inside the box hardware-wise, as well as a utility to
unpack the firmware into the kernel image and an ext2 ramdisk image.
There is other GPL and LGPL software runnning on the box - at least
busybox, uclibc, samba, and probably others.

If you have any questions, or if I should send this information
elsewhere, please let me know.  I am not subscribed to the list, so
please CC me on any replies.

Thanks,
Roy


