Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292295AbSBYUs0>; Mon, 25 Feb 2002 15:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292296AbSBYUsK>; Mon, 25 Feb 2002 15:48:10 -0500
Received: from fw2.primusdatacenter.net ([62.72.60.251]:17668 "HELO
	main.primuseurope.com") by vger.kernel.org with SMTP
	id <S292295AbSBYUrv>; Mon, 25 Feb 2002 15:47:51 -0500
Date: Mon, 25 Feb 2002 20:44:19 +0000
From: Manohar Pradhan <mpml@isp.primuseurope.com>
Reply-To: Manohar Pradhan <mpml@isp.primuseurope.com>
Message-ID: <154785420535.20020225204419@isp.primuseurope.com>
To: =?ISO-8859-1?B?SmFrb2Ig2HN0ZXJnYWFyZA==?= <jakob@unthought.net>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: Urgent SCSI I/O Error
In-Reply-To: <20020225210239.H24109@unthought.net>
In-Reply-To: <194779754037.20020225190953@isp.primuseurope.com>
 <20020225210239.H24109@unthought.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

If the Hard Drive is died, means I will need to replace. I have backup
for the Data in that /www partition.

Means when I replace new HDD, I will have to partition/format using
fdisk /sda ?

>From my partition info,

/dev/sdb6               917072    732972    137516  84% /
/dev/sda1                18820      5811     12037  33% /boot
/dev/sda6              2218336    462492   1643156  22% /www
/dev/sda5              5297560    418936   4609520   8% /home
/dev/sda7              1210440    711516    437436  62% /software
/dev/sdb1              5550188     50896   5217356   1% /usr
/dev/sdb5              2016016     28572   1885032   1% /var


My problematic HDD is /sda so if I replace this HDD, how can I boot as
boot images are in /sda1 /boot partition. How can I copy this boot
images to somewhere and make it work and what will be the process?

I know if I reboot and replace the HDD, it will give problem while
booting, any Idea to struggle with this?

Thanks a lot for all your help.

Regards
Manohar



Monday, February 25, 2002, 8:02:39 PM, you wrote:

JØ> On Mon, Feb 25, 2002 at 07:09:53PM +0000, Manohar Pradhan wrote:
>> Hi,
>> 
>> This question might have been raised before but I am stucked in
>> between wierd/helpless situation and wondering if someone can help me
>> out.
>> 
>> I have Red Hat Linux 6.2 (2.2.14-5.0smp) running in my HP Netserver
>> box. I have 2 9.1 GB HDD. The server has been up for few months and
>> have not had seen any problem. But today all of sudden it gave
>> panicking message saying following:
>> 
JØ> ...
>> Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:06: sense key Not Ready
>> Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:06, sector 0
>> Feb 25 18:48:12 nsdb1 kernel: SCSI disk error : host 0 channel 0 id 0 lun 0 return code = 28000002
>> Feb 25 18:48:12 nsdb1 kernel: [valid=0] Info fld=0x0, Current sd08:07: sense key Not Ready
>> Feb 25 18:48:12 nsdb1 kernel: scsidisk I/O error: dev 08:07, sector 0

JØ> Your disk died.  Physically.

JØ> ...
>> I can access files in all the other partitions but cannot access
>> files/directories in partition /www. I can see files in the
>> directories listing using 'ls' however accessing any file gives
>> Input/Output error saying:
>> 
>> cat check1.htm: Input/output error
>> 

JØ> Yep - can't read from bad blocks.

>> Can anyone help/suggest me what should I do to make it work? I am
>> wondering if I reboot the system, I may fall into problem on booting
>> itself. Is there any thing I need to do to make this partition work?

JØ> Replace the harddrive, restore from backup.

JØ> You will only have a problem booting, if the boot sector / kernel 
JØ> resides on that drive - and if that part of the drive is damaged
JØ> too.   It seems like that's not the case, but it would be wise
JØ> to run an "mkbootdisk" now, just in case.




-- 
Best regards,
 Manohar                            mailto:mpml@isp.primuseurope.com

