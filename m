Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVD0JO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVD0JO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 05:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVD0JO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 05:14:26 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:9993 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261297AbVD0JOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 05:14:23 -0400
Message-ID: <426F5902.6060901@aitel.hist.no>
Date: Wed, 27 Apr 2005 11:18:58 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Ext3+ramdisk journaling problem
References: <4ae3c14050424182235f916d7@mail.gmail.com> <cba141443b50f44069d7a92093a0d270@mac.com>
In-Reply-To: <cba141443b50f44069d7a92093a0d270@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Apr 24, 2005, at 21:22, Xin Zhao wrote:
>
>> hi,
>>
>> I used ramdisk as an ext3 journal and mount ext3 file system with
>> option data=journal. It worked fine and speedup the ext3 file system.
>
>
> Uhh, the whole point of a journal is that when the computer goes down
> hard and doesn't have a chance to clean up.  If you put the journal on
> a ramdisk, you might as well just mount it as an ext2 filesystem and
> be done with it.  Without the journal _on_disk_ you get no data or
> filesystem reliability advantages.  If you're after speed, just forgo
> the reliability or buy better disks.
>
Alternative: Buy a real ramdisk with battery-backup instead of using
a "ramdisk" in system ram.  Such a thing will last across a reboot,
offering both nice speed and all the comforts of a journal.

Helge Hafting

