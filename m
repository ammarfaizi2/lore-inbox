Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbUCJJc6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 04:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUCJJc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 04:32:57 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:42718 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262561AbUCJJct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 04:32:49 -0500
Date: Wed, 10 Mar 2004 15:05:31 -0500
From: Sesha Muneendra Swameejee Panda <Psm.Swamiji@Sun.COM>
Subject: Re: Kernel panic with SLES8.0
To: linux-kernel@vger.kernel.org
Reply-to: Psm.Swamiji@Sun.COM
Message-id: <404F750B.4040100@Sun.COM>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.0.1) Gecko/20020920
 Netscape/7.0
References: <404F5FC1.7070207@Sun.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


The follwing are the detailed messages while kernel panic.

------
Pending list:
Kernel Free SCB list: 3 1 0
DevQ(0:0:0): ) waiting
DevQ(0:0:0): ) waiting
aic7xxx_abort returnss 0x2002
scsi: device set offline - not ready or command retry failed after bus 
reset: ho
st 1 channel 0 id 15 lun 0
Loading module ext3 ...
Using /lib/modules/2.4.19-64GB-SMP/kernel/fs/ext3/ext3.0
kmod: failed to exec /sbin/modprobe -s -k block-major-8, errno = 2
VFS: Cannot open root device "sda2" or 08:02
Please append a correct "root=" boot option
kernel panic: VFS: Unable to mount root fs on 08:03
--------

The system has three partitions.

1. /dev/sda1  /boot   125 MB  ext3
2. /dev/sda2  /      30.5 GB  ext3
3. /dev/sda3  swap    3.5 GB  swap

And the RAM is 2048MB.

Boot options used : root=/dev/sda2 mem=2048M.

Any clues?

Thanks,
P.S.M.Swamiji




Sesha Muneendra Swameejee Panda wrote:
> Hi,
> 
> I have installed the SLES8.0 on a LX50 server. The installation went
> fine. While coming up the kernel panics with the below message.
> 
> kernel panic: VFS: Unable to mount root fs on 08:03
> 
> I have tried the workaround by give mem=2048M for boot options . This
> does not work and give the same problem.
> 
> Can anyone of you throw light on this?
> 
> Your help is highly appreciated.
> 


-- 

Regards,
P.S.M.Swamiji
Ph:2298989 x 27566

"LIFE IS ALREADY SHORT, DONT MAKE IT SHORTER by SMOKING OR
ARGUING."

