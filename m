Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292255AbSBYUkg>; Mon, 25 Feb 2002 15:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292250AbSBYUk0>; Mon, 25 Feb 2002 15:40:26 -0500
Received: from fw2.primusdatacenter.net ([62.72.60.251]:51322 "HELO
	main.primuseurope.com") by vger.kernel.org with SMTP
	id <S292222AbSBYUkH>; Mon, 25 Feb 2002 15:40:07 -0500
Date: Mon, 25 Feb 2002 20:36:35 +0000
From: Manohar Pradhan <mpml@isp.primuseurope.com>
Reply-To: Manohar Pradhan <mpml@isp.primuseurope.com>
Message-ID: <197784956397.20020225203635@isp.primuseurope.com>
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

Hello Jakob,

Thanks. I got another HDD read. but How can I install it, format and
make partition as earlier ( I have partition info though ..) and mount
it? Do I need to compile the Kernel or I can attach new HDD, and start
to create file systems inside.

Thanks for your enlightments.

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

