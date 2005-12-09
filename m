Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVLIESd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVLIESd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 23:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVLIESd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 23:18:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48035 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751273AbVLIESc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 23:18:32 -0500
Message-ID: <43990598.4080401@us.ibm.com>
Date: Thu, 08 Dec 2005 23:18:32 -0500
From: JANAK DESAI <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 3/5] New system call, unshare (powerpc)
References: <1134079969.5476.14.camel@hobbs.atlanta.ibm.com> <17304.62700.697323.531625@cargo.ozlabs.ibm.com>
In-Reply-To: <17304.62700.697323.531625@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I messed up. I created this against 2.6.15-rc5 and not rc5-mm1. I 
will do a new
build, unit test and post updated patches tomorrow.

-Janak

Paul Mackerras wrote:

>JANAK DESAI writes:
>
>  
>
>>--- 2.6.15-rc5-mm1/include/asm-powerpc/unistd.h	2005-12-06
>>21:06:19.000000000 +0000
>>+++
>>2.6.15-rc5-mm1+unshare-powerpc/include/asm-powerpc/unistd.h	2005-12-08
>>19:11:21.000000000 +0000
>>@@ -296,8 +296,9 @@
>> #define __NR_inotify_init	275
>> #define __NR_inotify_add_watch	276
>> #define __NR_inotify_rm_watch	277
>>+#define __NR_unshare		278
>>    
>>
>
>How does this apply against 2.6.15-rc5-mm1, which adds spu_run and
>spu_create as syscalls 278 and 279?
>
>Paul.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

