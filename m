Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754169AbWKGKJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbWKGKJx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754173AbWKGKJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:09:53 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:10510 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1754169AbWKGKJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:09:52 -0500
Message-ID: <45505B68.7000607@shadowen.org>
Date: Tue, 07 Nov 2006 10:09:44 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: schwidefsky@de.ibm.com, linux390@de.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-390@vm.marist.edu
Subject: Re: [PATCH] s390 need definitions for pagefault_disable and pagefault_enable
References: <20061101235407.a92f94a5.akpm@osdl.org> <7e94d9e3967f67b1151689921a21fd65@pinky> <20061107081326.GA7057@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20061107081326.GA7057@osiris.boeblingen.de.ibm.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens wrote:
> On Mon, Nov 06, 2006 at 06:35:21PM +0000, Andy Whitcroft wrote:
>> diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
>> index 9bbeaa0..ad296dc 100644
>> --- a/arch/s390/lib/uaccess_std.c
>> +++ b/arch/s390/lib/uaccess_std.c
>> @@ -11,6 +11,8 @@
>>  
>>  #include <linux/errno.h>
>>  #include <linux/mm.h>
>> +#include <linux/uaccess.h>
>> +
>>  #include <asm/uaccess.h>
>>  #include <asm/futex.h>
> 
> http://lkml.org/lkml/2006/11/2/54
> 
> ;)

Perhaps it would be helpful if these went out as replies to akpm's -mm
announcement else you have to sift the whole of lkml for them :(.

-apw
