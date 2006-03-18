Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWCRXuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWCRXuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWCRXuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:50:03 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:7300 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S1751139AbWCRXuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:50:02 -0500
Message-ID: <441C9D44.6010209@wolfmountaingroup.com>
Date: Sat, 18 Mar 2006 16:52:36 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3ware 6x00 monitor/control utilities broken/dropped since 2.6.10?
References: <17435.43034.364906.429948@wellington.i202.centerclick.org> <441C7760.3000405@wolfmountaingroup.com>
In-Reply-To: <441C7760.3000405@wolfmountaingroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Corrected FTP link.

ftp://ftp.soleranetworks.com/pub/solera/dsfs/RedHatEnterprise4/


Jeff

Jeffrey V. Merkey wrote:

> Dave,
>
> I had to revert to 2.6.9-22 ES4 kernels to solve this, and I still 
> needed to update the 3Ware driver in 2.6.9. There's a patch that 
> includes the latest 3Ware drivers that appears to make this work at 
> ftp.soleranetworks.com:/var/ftp/pub/solera/dsfs/. Look under the ES4 
> directory for the kernel and patch.
>
> Jeff
>
> Dave Johnson wrote:
>
>> I have a 3ware 6400 controller that I've been using for some 5 years
>> without problems. I just upgraded my kernel from 2.6.9 to
>> 2.6.15.6 and now the 3ware provided monitoring/control daemon (3dm) will
>> no longer talk to the driver in 2.6.15.
>>
>> It appears that /proc/scsi/3w-xxxx which the daemon relies on was 
>> removed
>> from the driver:
>>
>> open("/proc/scsi/3w-xxxx", 
>> O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOENT (No such 
>> file or directory)
>> open("/proc/scsi/3w-xxxx-z", 
>> O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = -1 ENOENT (No such 
>> file or directory)
>>
>> The problem is I'm already using the latest 3ware utilities (v6.9 for
>> the 6400). While the driver does allow access to the array from the
>> SCSI subsystem and I can use the filesystem, I have no way to monitor
>> or control it anymore.
>>
>> Any suggestions besides reverting back to 2.6.9 and staying there?
>>
>> I'd be happy to use a different monitor/control program if one exists.
>>
>>
>>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at http://www.tux.org/lkml/
>

