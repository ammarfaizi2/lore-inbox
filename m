Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWEPP0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWEPP0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWEPP0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:26:05 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:33741 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S932093AbWEPP0D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:26:03 -0400
Message-ID: <4469EF6F.7050801@cmu.edu>
Date: Tue, 16 May 2006 11:27:43 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: problem booting 2.4.32, unknown symbol
References: <4469E51E.80103@cmu.edu>	<20060516075340.8d387ddb.rdunlap@xenotime.net>	<4469E839.3090806@cmu.edu> <20060516081442.579d3c12.rdunlap@xenotime.net>
In-Reply-To: <20060516081442.579d3c12.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Randy.Dunlap wrote:
> On Tue, 16 May 2006 10:56:57 -0400 George Nychis wrote:
> 
>>
>> Randy.Dunlap wrote:
>>> On Tue, 16 May 2006 10:43:42 -0400 George Nychis wrote:
>>>
>>>> Hi,
>>>>
>>>> I am trying to boot 2.4.32 with FC3, whenever i try to boot i get the
>>>> following errors:
>>>>
>>>> insmod: error inserting `/lib/scsi_mod.o': -1 Unknown symbol in module
>>>> ERROR /bin/insmod excited abnormally!
>>>> insmod: error inserting `/lib/sd_mod.o': -1 Unknown symbol in module
>>>>
>>>> I get the same error for libata.o, ata_piix.o, and lvm-mod.o
>>>>
>>>> then i get failed to create /edv/ide/host0/bus0/target0/lun0/disc
>>>>
>>>> So my guess is trying to fix the top most first
>>>>
>>>> Anyone have any ideas?
>>> I don't know the problem, but dmesg should show you/us the
>>> actual symbol that is wanted and missing, so please provide that.
>>>
>>> ---
>>> ~Randy
>>>
>> If the system doesn't boot, how can i get the dmesg?
> 
> aha, my bad, sorry.
> I'll have to defer to someone who knows about FC3.
> 
> ---
> ~Randy
> 

Some more info, my bottom most errors:

ERROR: failed in exec of vgscan
ERROR: failed in exec of vgchange
mount: error 6 mounting ext3
pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed: 2
umount /initrd/proc failed: 2
ERROR: vchange exited abnormally!
mkrootdev: mknod failed: 17
...
...
Kernel panic: No init found.  Try passing init= option to kernel

- George
