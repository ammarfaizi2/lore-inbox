Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUJINLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUJINLc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUJINLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:11:32 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:50378 "EHLO
	vsmtp3alice.tin.it") by vger.kernel.org with ESMTP id S266802AbUJINL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:11:29 -0400
Message-ID: <4167E3A5.8080807@ircom.org>
Date: Sat, 09 Oct 2004 15:12:05 +0200
From: Fwiffo <fwiffo@ircom.org>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: GPL issues with a company
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excuse me if I'm sending it in the wrong place, but since I don't really 
know were to send it to, I've put the thing in here, since I think this 
should be noticed by whom is passing time over code where someone else 
now is doing whatevere he wants without respect...

Since I don't have much time, I'm pasting the letter I sent to the 
squashfs author, it contains necessary information, plus I add something 
in the end:

*-----------------------------------*
Hi,

I'm sending this notice to communicate to you that a company, formely 
named dynalink, in new zeland,
http://www.dynalink.co.nz/ is selling one (at least to my knowledge, I 
don't have investigated any further) ADSL that contain a modified Linux 
Kernel version with squashfs support, further investigation to the 
relevant portion of the squashfs filesystem gave me notice that maybe 
they've done relevant modification to your filesystem, but haven't, 
until now, and after my request, put a single source code line, nor of 
the linux kernel, nor of the uclib nor of the squashfs and whatever 
they've there....

http://fwiffo.altervista.org/gigaset.bin contains the firmware of the 
modem in question (known as RTA230 in the dynalink page), the processor 
is a MIPS32, below output from modem's proc filesys:
-----
system type             : RTA230
processor               : 0
cpu model               : BCM6345 V0.0
BogoMIPS                : 92.97
wait instruction        : no
microsecond timers      : yes
tlb_entries             : 32
extra interrupt vector  : no
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
-----
As you can see in the gigaset.bin, after exactly 256 bytes begins the 
squashfs (typical big endian style, since we are talking of big endian 
machine), but, at least to my little knowledge of programming and of the 
filesystem in question (I'm very ignorant for that matter, but at least 
I've spotted a few things....) I've seen that this isn't the usual 
output of one of your squashfs tools....
And also, I've taken the squashfs image from the device directly as 
output from the RTA230 's modem, but hadn't any success in using it with 
any of your patch, so, we are in front of a modification maybe?!
...I hope that at least those things will be useful to you...If you also 
look in http://fwiffo.altervista.org even if the page is in italian, you 
will see an image of the modem in the end of the page; that very modem 
is distributed by Telecom Italia S.p.A., a company were I work, and is 
rebranded by Siemens, here the modem's name is: Alice ADSL Gigaset .

If you want to know something else, I'm here to answer.

Puligheddu Karsten

PS: I guess they're also violating GPL....and I guess I will send 
similiar notices to LINUX ML and uclib authors... *
-----------------------------------
# cat /proc/version
Linux version 2.4.17 (michaelc@ADSL_SW1_LINUX) (gcc version 3.1) #1 Mon 
May 10 1
5:30:45 CST 2004
*
