Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVCVTc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVCVTc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVCVT35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:29:57 -0500
Received: from alog0071.analogic.com ([208.224.220.86]:57005 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261710AbVCVT3b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:29:31 -0500
Date: Tue, 22 Mar 2005 14:26:52 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek on /proc/kmsg
In-Reply-To: <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0503221423560.6369@chaos.analogic.com>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
 <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2005, Jan Engelhardt wrote:

> Hi,
>
>> how am I supposed to clear the kmsg buffer since it's not a terminal??
>
> fd = open("/proc/kmsg", O_RDONLY | O_NONBLOCK);
> while(read(fd, buf, sizeof(buf)) > 0);
> if(errno == EAGAIN) { printf("Clear!\n"); }
>
> This is language (spoken-wise) neutral :p
>

Gawd, you are a hacker. I already have to suck on pipes
because I can't seek them. Now, I can't even seek a
file-system???!!

>
>
> Jan Engelhardt
> -- 
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
