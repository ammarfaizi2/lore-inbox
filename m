Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSL2U7S>; Sun, 29 Dec 2002 15:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSL2U7S>; Sun, 29 Dec 2002 15:59:18 -0500
Received: from falcon.vispa.uk.net ([62.24.228.11]:23046 "EHLO
	falcon.vispa.com") by vger.kernel.org with ESMTP id <S261689AbSL2U7R>;
	Sun, 29 Dec 2002 15:59:17 -0500
Message-ID: <3E0F63FD.60903@walrond.org>
Date: Sun, 29 Dec 2002 21:07:09 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Rolland <rol@as2917.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5.53] So sloowwwww......
References: <00bd01c2af5d$6b0404c0$2101a8c0@witbe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mount a tmpfs drive and try building the kernel there to rule out scsi 
or disc issues. (You've got .5Gb I think? Might not want to run kde as 
well; just build from a console)

But I think your ACPI guess is probably not far wrong.

Paul Rolland wrote:
> Hello,
> 
> 
>>Ouch; that is slow. What partition type are you building from ?
>>
> 
> This is an ext3 partition, and a SCSI disk :
> 4 [18:10] rol@donald:/kernels> df .
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda1             10320888    753828   9042724   8% /kernels
> 
> Do you think I should try on some other ?
> The problem is that the system is *globally* slow, and compiling
> the kernel is just a way to prove it. Starting KDE has become a real
> pain (so slow screen detects no more video and enter Energy Saving
> mode before reactivating and switching to Graphic mode).
> 
> Regards,
> Paul
> 


