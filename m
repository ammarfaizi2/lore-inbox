Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVGZDCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVGZDCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 23:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVGZDCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 23:02:42 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:39341
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261602AbVGZDCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 23:02:41 -0400
Message-ID: <42E599C5.5090705@linuxwireless.org>
Date: Mon, 25 Jul 2005 21:02:45 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Puneet Vyas <vyas.puneet@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org> <42E5927B.20506@gmail.com>
In-Reply-To: <42E5927B.20506@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Puneet Vyas wrote:

> Alejandro Bonilla wrote:
>
>> Puneet Vyas wrote:
>>
>>>
>>> PS : I am not even sure if I am "allowed" to pull out the writer 
>>> like this. Am I supposed to "stop" the device first or something?
>>>
>> You are supoused to unmount the volume. Try it. umount /dev/cdrom ? 
>> Make sure that is it not in use, then unload it.
>> New versions of gnome and so have the option to right click the 
>> loaded device and then to unmount.
>>
>> It should never hang. Does it hang with the floppy when removed?
>
>
> 1. When I did umount /dev/cdrom it says - "umount: /dev/hdc is not 
> mounted (according to mtab)"
> 2. Yes
>
> Thanks,
> Puneet


You are trying to unmount a /dev/hdc? hdc is an IDE Hard Drive, you have 
a CD burner, I would doubt that it is /de/hdc.
type mount and that will tell you what is mounted, try umount 
/dev/cdrom. You need the hardware unloaded.

Try /etc/init.d/hotplug stop and unplugg the hardware. See if that hangs 
the PC.

Figure out on how to unload the module, then you will need to get us 
more info here for this problem to be looked...

anyone has more suggestions?

.Alejandro

