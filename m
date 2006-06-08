Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWFHBJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWFHBJx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 21:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWFHBJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 21:09:52 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:29101 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932515AbWFHBJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 21:09:52 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc6-mm1
Date: Thu, 08 Jun 2006 11:09:44 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <dtte829fe6umbkg053o9hc5pbi34vq4shn@4ax.com>
References: <20060607104724.c5d3d730.akpm@osdl.org> <44875DC0.2000406@mbligh.org> <20060607165521.f4aa1898.akpm@osdl.org>
In-Reply-To: <20060607165521.f4aa1898.akpm@osdl.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2006 16:55:21 -0700, Andrew Morton <akpm@osdl.org> wrote:

>On Wed, 07 Jun 2006 16:14:08 -0700
>Martin Bligh <mbligh@mbligh.org> wrote:
>
>> Andrew Morton wrote:
>> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
>> 
>> 
>> 
>> Build failures on everything but x86_64 (possibly different distro
>> or something)
>> 
>>    GEN     usr/klibc/syscalls/SYSCALLS.i
>> /usr/local/autobench/var/tmp/build/usr/klibc/SYSCALLS.def:30:26: missing 
>> terminating ' character
>> make[3]: *** [usr/klibc/syscalls/SYSCALLS.i] Error 1
>> make[2]: *** [usr/klibc/syscalls] Error 2
>> make[1]: *** [_usr_klibc] Error 2
>> make: *** [usr] Error 2
>> 06/07/06-18:23:44 Build the kernel. Failed rc = 2
>> 06/07/06-18:23:44 build: kernel build Failed rc = 1
>> 06/07/06-18:23:44 command complete: (2) rc=126
>> Failed and terminated the run
>>   Fatal error, aborting autorun
>
>dammit, I fixed that and then didn't manage to include the fix in the rollup.
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/broken-out/klibc-ia64-fix.patch

Thanks, Andrew -- perhaps you could copy this patch to 
.../2.6.17-rc6-mm1/hot-fixes ?  I was caught too and checked 
for hot-fixes, empty.

Grant.
