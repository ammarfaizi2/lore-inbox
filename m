Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUAOAnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266313AbUAOAnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:43:49 -0500
Received: from cmailm5.svr.pol.co.uk ([195.92.193.21]:4534 "EHLO
	cmailm5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S264949AbUAOAlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:41:13 -0500
Message-ID: <4005E0E5.2030003@sms.ed.ac.uk>
Date: Thu, 15 Jan 2004 00:37:57 +0000
From: Michael Lothian <s0095670@sms.ed.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031202
X-Accept-Language: en-gb, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Catch 22
References: <400554C3.4060600@sms.ed.ac.uk>	<20040114090137.5586a08c.jkl@sarvega.com> <20040114091456.752ad02d.rddunlap@osdl.org> <40058DAB.30802@grupopie.com>
In-Reply-To: <40058DAB.30802@grupopie.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:

>
>>
>
>
> I guess the problem is that, by default, Mandrake creates an extended 
> partition when installed, where all the other partitions go.
>
> Whenever I install Mandrake, I'm always careful to switch to "Expert" 
> mode and configure the partitions to be primary by hand to avoid this 
> kind of problems.
>
> If you are a corageous hacker, you can always:
>
>  - boot from a CD distribution (knoppix, etc.)
>  - run fdisk on your hard drive
>  - take note on the cylinders being used by the partitions,
>  - delete the partitions on the extended partition, and the extended 
> partition itself
>  - create the partitions again as primary using the *exact* same 
> cylinders
>  - write the partition to disk
>  - reboot
>
> Probably you'll have to adjust fstab to use the new partitions, but at 
> least 2.4 and 2.6 should both agree that you have an hda :)
>
> I don't know if you'll need to run lilo again before rebooting, but I 
> would do that just to be on the safe side. To do that:
>
>  - mount /dev/hda somewhere (/mnt/disk or something)
>  - # cd /mnt/disk
>  - edit etc/lilo.conf to always use /dev/hda
>  - # chroot . lilo
>
> I hope this helps,
>
I assumed it was because 2.6 was labeling the SATA controllers before
the ATA ones but this is the least of my worries of 2.6. If everything
else worked with 2.6 I wouldn't need to switch between the two.

My biggest woe is that despite having a very cool graphics card I can't
play Warcraft III using WineX. (Which was the reason for my upgrade)

Mike

