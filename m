Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUEVWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUEVWgc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUEVWgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 18:36:32 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:41963 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S261939AbUEVWga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 18:36:30 -0400
Date: Sat, 22 May 2004 16:38:09 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Flavio Stanchina <flavio@stanchina.net>
Cc: system <system@eluminoustechnologies.com>, linux-kernel@vger.kernel.org
Subject: Re: hda Kernel error!!!
Message-ID: <20040522223809.GA6527@bounceswoosh.org>
Mail-Followup-To: Flavio Stanchina <flavio@stanchina.net>,
	system <system@eluminoustechnologies.com>,
	linux-kernel@vger.kernel.org
References: <200405221257.28570.system@eluminoustechnologies.com> <40AF7080.50607@stanchina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <40AF7080.50607@stanchina.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22 at 17:23, Flavio Stanchina wrote:
>system wrote:
>>    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
>>    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  
>>    1Time(s)
>>
>>What is this error?
>
>You need to tell us:
>- kernel version
>- make and model of the hard disk
>- make and model of the controller (or chipset)
>
>If you are using kernel 2.6.6 and a Maxtor disk, then it's a known 
>problem. Search the LKML archives and look at the post-2.6.6 changes to 
>drivers/ide/ide-disk.c.

There are hundreds, if not thousands of ways to get a 0x5104 response
from an IDE drive.  Without more information on what was going on at
the time, it's tough to say whether this is the same issue.

Only a few Maxtor drives (relatively) were affected with this most
recent issue, and the original author didn't post a drive model
number.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

