Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVAYToI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVAYToI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVAYTlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:41:01 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:62639 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262094AbVAYThw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:37:52 -0500
Message-ID: <41F6A00A.6070404@drzeus.cx>
Date: Tue, 25 Jan 2005 20:37:46 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Page fault in umount
References: <41F1A90D.5000809@drzeus.cx> <20050124164524.3589856a.akpm@osdl.org>
In-Reply-To: <20050124164524.3589856a.akpm@osdl.org>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>  
>
>>When I yank out my MP3 player, the programs trying to umount the disk 
>>cause the following page fault:
>>
>>...
>>EIP is at scsi_device_put+0xf/0x70 [scsi_mod]
>>    
>>
>
>This should be fixed in 2.6.11-rc2-mm1, via bk-scsi-rc-fixes.patch.  Could you
>retest with either
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/2.6.11-rc2-mm1.bz2
>
>or
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/2.6.11-rc2-mm1/broken-out/bk-scsi-rc-fixes.patch
>
>applied?
>  
>
The patch seems to solve the problem. Thanks.

Rgds
Pierre

