Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265265AbSJXARN>; Wed, 23 Oct 2002 20:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265271AbSJXARN>; Wed, 23 Oct 2002 20:17:13 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:12540 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id <S265265AbSJXARM>; Wed, 23 Oct 2002 20:17:12 -0400
Message-ID: <3DB73E2A.5090001@mvista.com>
Date: Wed, 23 Oct 2002 17:26:18 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, alan@lxorquk.ukuu.org.uk
Subject: Re: [PATCH] Advanced TCA SCSI/FC disk hotswap driver for kernel 2.5.44
References: <3DB7304A.3030903@mvista.com> <20021024001818.GH17413@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,


Greg KH wrote:

>On Wed, Oct 23, 2002 at 04:27:06PM -0700, Steven Dake wrote:
>  
>
>>Changes from kernel 2.4.19 to 2.5.44 release:
>>    
>>
>
>First off, your patch is line wrapped, please fix your email client.
>
>Also, please read Documentation/CodingStyle and use tabs.  Unless this
>is a side effect of your email client munging the patch.
>  
>
Thanks yes, it is definately this brain dead mozilla mailer.  I did use 
tabs of course.

>  
>
>>* ioctls deleted and replaced by ramfs scsi_hotswap_fs (suggested by
>>Greg KH)
>>    
>>
>
>Any reason you can't use driverfs for the 2.5 code?
>
>  
>
I'm not sure how driverfs would be used by this particular patch.  Could 
you be more specific in stating how this could be used?

>  
>
>>+/*
>>+ * Core file read/write operations interfaces
>>+ */
>>+static char scsi_hotswap_insert_by_scsi_id_usage[] = {
>>+    "Usage: echo \"[host] [channel] [lun] [id]\" > insert_by_scsi_id\n"
>>+};
>>    
>>
>
>I really like this, a user friendly kernel interface :)
>  
>
Think this looks good for inclusion in 2.5.45?

Thanks
-steve

>thanks,
>
>greg k-h
>
>
>
>  
>

