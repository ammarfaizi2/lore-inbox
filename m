Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVB0Tej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVB0Tej (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVB0Tei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:34:38 -0500
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165]:42195 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261485AbVB0Tdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:33:55 -0500
Message-ID: <422220C7.8090001@xfs.org>
Date: Sun, 27 Feb 2005 13:34:31 -0600
From: Stephen Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Torben Viets <Viets@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS dm_crypt BUG?
References: <422214D6.2000206@web.de>
In-Reply-To: <422214D6.2000206@web.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torben Viets wrote:
> Hello,
> 
> I have a problem with the XFS-filesystem, I use the Kernel 2.6.10 and 
> 2.6.11-rc4 and rc5 everytime the same behavior.
> 
> I have a RAID 5(md0) with 3 disks on md0 (chunk-size 128) there is a 
> logical volume (/dev/data/mp3-crypt) which is crypted with AES and the 
> encrypted version ist under /dev/mapper/mp3, if the filestem on it is 
> xfs and then copie some files on it then I get a kernel panic, mostly on 
> greater files (>200MB), if I make the same thing with ext3 there is no 
> problem. My first thougt was that the problem is that I make a snapshot 
> of the device, but if i remove this it won't work anyway.
> 
> My sytem is a Pentium4 1800Mhz
> 512 MB SDRAM
> 
> I can't show you the kernel panic message, because I didn't found it in 
> the syslog, it is only on the screen,
> 
> I'm not sure what infos you need too.
> 
> greetings
> Torben Viets
> 

The complete kernel panic is what is needed to get anywhere with this.

If all else fails, get a digital camera and take a picture of it,
although you may need to reconfigure your console to get enough lines
displayed. A console down a serial line to another computer is the best
way of capturing these though.

Just on a hunch, check if you have 4K stacks turned on, if you do, go
back to 8K stacks and see if that cures it.

Steve


