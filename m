Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283510AbRK3F1W>; Fri, 30 Nov 2001 00:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283509AbRK3F1M>; Fri, 30 Nov 2001 00:27:12 -0500
Received: from wiprom2mx2.wipro.com ([203.197.164.42]:60036 "EHLO
	wiprom2mx2.wipro.com") by vger.kernel.org with ESMTP
	id <S283510AbRK3F0x>; Fri, 30 Nov 2001 00:26:53 -0500
Message-ID: <3C0715CF.8050703@wipro.com>
Date: Fri, 30 Nov 2001 10:44:55 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch to update scsi_debug.c
In-Reply-To: <3C071573.5090EB1@interlog.com>
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-62e569e5-e550-11d5-a216-0000e22173f5"
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-62e569e5-e550-11d5-a216-0000e22173f5
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The ramdisk emulation should be easy to do, you
can get sample code from most of the iSCSI
implementations on Linux. Most of them simulate a
ramdisk on the target side.

Balbir

Douglas Gilbert wrote:

>Pete Zaitcev <zaitcev@redhat.com> wrote:
>
>>I would like to have scsi_debug with a variable number 
>>of hosts. Patch is attached. Does anyone object to the 
>>demise of scsi_debug.h?
>>
>
><snipped patch/>
>
>Pete,
>Maybe you may like to consider this effort. Apart from allowing
>extra hosts (hundreds of them via boot/module option) it is
>like a RAM disk. The default RAM allocation is 8 MB which
>can be overridden by a boot/module option. You can
>run fdisk on it, make a fs, mount it, etc.
>
>See:
>http://www.torque.net/sg/sdebug.html
>
>It runs properly on SMP (Eric's didn't) and supports a
>reasonable number of SCSI commands including READ_16 and
>WRITE_16. I used the latter 2 commands to test (via sg)
>that the recently added 16 byte CDBs worked.
>
>BTW I kept scsi_debug.h as most other SCSI adapter drivers
>have .h and .c components.
>
>Doug Gilbert
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>



------=_NextPartTM-000-62e569e5-e550-11d5-a216-0000e22173f5
Content-Type: text/plain;
	name="InterScan_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="InterScan_Disclaimer.txt"

-------------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------

------=_NextPartTM-000-62e569e5-e550-11d5-a216-0000e22173f5--
