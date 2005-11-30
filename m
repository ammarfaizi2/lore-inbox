Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVK3NG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVK3NG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 08:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVK3NG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 08:06:29 -0500
Received: from mail.ceskyhosting.cz ([81.0.238.178]:38130 "EHLO
	mail.cesky-hosting.cz") by vger.kernel.org with ESMTP
	id S1751208AbVK3NG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 08:06:28 -0500
Message-ID: <438DA3FA.2010809@eq.cz>
Date: Wed, 30 Nov 2005 14:07:06 +0100
From: "0602@eq.cz" <0602@eq.cz>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051129)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-kernel@vger.kernel.org, Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: totally random "VFS: Cannot open root device"
References: <438B6E05.8070009@eq.cz> <438D2C19.3030008@gmail.com>
In-Reply-To: <438D2C19.3030008@gmail.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Please CC me your answers as I am not subscribed.)

Tejun Heo wrote:
[...]
> Can you please post dmesg of a successful booting?  That will tell us 
> which SATA controller/disks you are using.  Also, the boot log of a 
> failed boot will be very helpful - the best way to get this is via 
> serial console.  If you don't have access to serial console, taking note 
>   / picture of the part where SATA detection fails will do too.

I've placed the dmesg and the picture of panic here: http://26143.eq.cz/

> 
> Also, when the machine boots successfully, does it work without 
> generating disk related kernel logs?  Just perform any IO-heavy 
> operations - cp'ing directories which contain large files, 
> tar/untarring... - and see if the kernel complains about anyting.
> 

There are no signs of anything wrong in logs, all my IO tests passed ok.

Regards,

r.
