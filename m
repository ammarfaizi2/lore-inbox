Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUAVPTL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbUAVPTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:19:11 -0500
Received: from mail.rdslink.ro ([193.231.236.20]:57017 "EHLO mail.rdslink.ro")
	by vger.kernel.org with ESMTP id S263927AbUAVPTI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:19:08 -0500
Message-ID: <400FE9A5.5060500@rdslink.ro>
Date: Thu, 22 Jan 2004 17:17:57 +0200
From: "Beratco Matei jr." <mathew@rdslink.ro>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: ro, en-us, en
MIME-Version: 1.0
To: Carlos Velasco <lkernel@newipnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: iswraid calling modprobe when scsi statically  compiled?
References: <400C50FA.5070809@rdslink.ro> <200401201130310490.1D90BAC9@192.168.128.16>
In-Reply-To: <200401201130310490.1D90BAC9@192.168.128.16>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>* Sorry by the off-topic *
>However I have problems when booting. I'm using GRUB trying to boot
>directly over ICH5R RAID without any success. It doesn't see any known
>filesystem in (hd0).
>Are you booting directly to RAID disks? I'm using RAID1, it may be a
>bit different.
>What boot loader are you using?
>  
>
I'm using grub from RedHat 9. I did have redhat installed on my 3rd disk 
and moved it to my
raid array (a lot later). When I installed it, i had to install grub on 
floppy,
boot from floppy, enter command-line and install to HDD from floppy. 
This is because
the grub from redhat (i mean after you booted) doesn't detect the RAID 
correctly, and still sees
hd0 as the primary master disk (hda, my 3rd disk).

Anyway, this is what i've done, and it works. I actually installed it on 
the ext3 partition (from my
raid) , and the MBR is the "standard" one from windows, with the ext3 as 
primary (so I can
reinstall the other OS anytime without reinstalling grub).

