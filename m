Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbUB1QvQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUB1QvQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 11:51:16 -0500
Received: from uranium.btinternet.com ([194.73.73.89]:11654 "EHLO
	uranium.btinternet.com") by vger.kernel.org with ESMTP
	id S261878AbUB1QvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 11:51:15 -0500
Message-ID: <4040C710.6010908@btopenworld.com>
Date: Sat, 28 Feb 2004 16:51:28 +0000
From: Subodh Shrivastava <subodh@btopenworld.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: sbp2 module not initialising external hdd connected on firewire
 port.
References: <40409D0A.8040903@btopenworld.com> <20040228144134.GC1152@phunnypharm.org>
In-Reply-To: <20040228144134.GC1152@phunnypharm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:

>On Sat, Feb 28, 2004 at 01:52:10PM +0000, Subodh Shrivastava wrote:
>  
>
>>Hi Ben,
>>
>>I am trying to connect my external HDD on firewire port. Linux is not 
>>recognising this disk. Same disk is recognised in windows, also its 
>>recognised in linux when connected on USB port. Attached here is my 
>>.config file, lspci output, dmesg output.
>>
>>uname -a:
>>Linux subbu 2.6.3-mm2 #9 Sat Feb 28 13:11:28 GMT 2004 i686 Intel(R) 
>>Pentium(R) M processor 1300MHz GenuineIntel GNU/Linux
>>    
>>
>
>Can you do "ls -l /sys/bus/ieee1394/devices/" ?
>
>  
>
subbu-gentoo root # ls -l /sys/bus/ieee1394/devices/
total 0
lrwxrwxrwx    1 root     root           79 Feb 28 13:13 0010b92000e4f18d 
-> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:07.0/fw-host0/0010b92000e4f18d
lrwxrwxrwx    1 root     root           98 Feb 28 13:13 
0010b92000e4f18d-0 -> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:07.0/fw-host0/0010b92000e4f18d/0010b92000e4f18d-0
lrwxrwxrwx    1 root     root           79 Feb 28 13:13 00c09f00000a5e53 
-> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:07.0/fw-host0/00c09f00000a5e53
lrwxrwxrwx    1 root     root           62 Feb 28 13:13 fw-host0 -> 
../../../devices/pci0000:00/0000:00:1e.0/0000:02:07.0/fw-host0
