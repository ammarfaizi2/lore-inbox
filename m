Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTDGORK (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbTDGORK (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:17:10 -0400
Received: from imap.gmx.net ([213.165.64.20]:3448 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262623AbTDGORI (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 10:17:08 -0400
Message-ID: <3E918B13.4080805@gmx.net>
Date: Mon, 07 Apr 2003 16:28:35 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems booting PDC20276 with new IDE setup code.
References: <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org> <Pine.LNX.4.44.0304070201420.8701-100000@sharra.ivimey.org> <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
In-Reply-To: <5.2.0.9.0.20030407141330.00b346c0@mailhost.ivimey.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ruth Ivimey-Cook wrote:
> At 03:34 07/04/2003, Carl-Daniel Hailfinger wrote:
> 
>> Could you please try 2.4.21-pre7 (this has another batch of IDE 
>> updates) and enable the option
>> "Special FastTrak Feature"?
>> In your .config, the option would be
>> CONFIG_PDC202XX_FORCE=y
>> and report back to the list?
> 
> For reasons reported in another mail (ac97 fails to build) my attempt at 
> pre7 failed. Also, as far as I know, the FastTrak feature enables the 
> Promise RAID mode: I am not using that. Instead, I just want 4 IDE disks 
> which will be bound using Linux raid5.

No, without the "Special FastTrak Feature" you cannot see the disks at 
all, regardless if you want RAID or plain IDE.

> Are you saying you want to know if the Promise mode works (independent 
> of whether I wish to use it?)

I'm currently trying to find out if enabling the "Special FastTrak 
Feature" is hurting anyone. So far, it seems that enabling it only 
conflicts with the binary only driver from Promise.

If you want to see your disks, please enable the feature.

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org

