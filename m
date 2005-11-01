Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVKABAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVKABAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 20:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVKABAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 20:00:15 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:60230 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964863AbVKABAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 20:00:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:organization:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bJcEIU2LDSzIDGM4cLv/+8aaWpff5wDcxt0u023SGCO4ewqOgbDf6iQrtF96uA0i0kNQo5Ve9QHI1H29twcIiu4Sn5c5Ty2KJYLt81AagJk6G/S96BzTSzEnNrjPlTyvl46NzYqJ/UznGVtEeIz8flRUSEAwyhH7igCao9AziW4=
Message-ID: <4366BE0C.7050907@gmail.com>
Date: Tue, 01 Nov 2005 11:59:56 +1100
From: Grant Coady <gcoady@gmail.com>
Organization: http://bugsplatter.mine.nu/
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, zippel@linux-m68k.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk, tony.luck@gmail.com,
       paolo.ciarrocchi@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>	<20051031001647.GK2846@flint.arm.linux.org.uk>	<20051030172247.743d77fa.akpm@osdl.org>	<200510310341.02897.ak@suse.de>	<Pine.LNX.4.61.0511010039370.1387@scrub.home>	<20051031160557.7540cd6a.akpm@osdl.org>	<Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org>
In-Reply-To: <20051031163408.41a266f3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 2.4.x doesn't have allnoconfig, so no numbers for that.

-rw-r--r--  1 root root    7501 2005-11-01 10:57 config-2.4.31-none
-rw-r--r--  1 root root  249263 2005-11-01 10:57 bzImage-2.4.31-none
-rw-r--r--  1 root root   71548 2005-11-01 10:57 System.map-2.4.31-none

These things snuck in (everything on make menuconfig cleared):

grant@sempro:~/linux/linux-2.4.31-none$ grep = .config
CONFIG_X86=y
CONFIG_UID16=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_LOG_BUF_SHIFT=0
grant@sempro:~/linux/linux-2.4.31-none$

Cheers,
Grant.
