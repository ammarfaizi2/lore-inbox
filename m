Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGZAy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGZAy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 20:54:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVGZAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 20:54:58 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:10710
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261577AbVGZAy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 20:54:58 -0400
Message-ID: <42E57BD6.4090006@linuxwireless.org>
Date: Mon, 25 Jul 2005 18:55:02 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Puneet Vyas <vyas.puneet@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:Machine hangs on pulling out USB cd writer on laptop.
References: <42E58483.2050602@gmail.com> <42E57ACD.8070909@linuxwireless.org>
In-Reply-To: <42E57ACD.8070909@linuxwireless.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla wrote:

> Puneet Vyas wrote:
>
>> Hi,
>>
>> My Dell 600m has a CD writer attached as a USB device. I need to use 
>> the same slot to connect my floppy drive. After pulling out the CD 
>> writer , the machine completely hangs and only hard boot works. I am 
>> new to reporting bugs so I attached all info as according to 
>> REPORTING-BUGS. Please let me know if more info is needed.Thanks.
>>
>> Warm regards,
>> Puneet Vyas
>>
>> PS : I am not even sure if I am "allowed" to pull out the writer like 
>> this. Am I supposed to "stop" the device first or something?
>>
> You are supoused to unmount the volume. Try it. umount /dev/cdrom ? 
> Make sure that is it not in use, then unload it.
> New versions of gnome and so have the option to right click the loaded 
> device and then to unmount.
>
> It should never hang. Does it hang with the floppy when removed?
>
> .Alejandro
> -
>
Also, go to a tty (ctrl+alt+f1), login and then unplug the device, If it 
gives a kernel panic, show the output here.

.Alejandro

