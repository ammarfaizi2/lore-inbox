Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291817AbSBHVJP>; Fri, 8 Feb 2002 16:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291813AbSBHVJG>; Fri, 8 Feb 2002 16:09:06 -0500
Received: from f40.law11.hotmail.com ([64.4.17.40]:18963 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291817AbSBHVIy>;
	Fri, 8 Feb 2002 16:08:54 -0500
X-Originating-IP: [156.153.254.2]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: KSTK_EIP and KSTK_ESP
Date: Fri, 08 Feb 2002 13:08:49 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F40UtI9dm5UxP9Fekza00014711@hotmail.com>
X-OriginalArrivalTime: 08 Feb 2002 21:08:49.0312 (UTC) FILETIME=[CDB22200:01C1B0E4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My fault, I was using lxr.linux.no. I was also confused by
the way it is defined in include/asm-parisc (2.4.17)

#define KSTK_EIP(tsk)   (0xdeadbeef)
#define KSTK_ESP(tsk)   (0xdeadbeef)

Thanks for pointing this out,
Balbir



>From: "David S. Miller" <davem@redhat.com>
>To: balbir_soni@hotmail.com
>CC: linux-kernel@vger.kernel.org, tigran@veritas.com
>Subject: Re: KSTK_EIP and KSTK_ESP
>Date: Fri, 08 Feb 2002 12:55:22 -0800 (PST)
>
>    From: "Balbir Singh" <balbir_soni@hotmail.com>
>    Date: Fri, 08 Feb 2002 12:36:59 -0800
>
>    Do we really need these defines, I found that it
>    is not used anywhere and defined as deadbeef on
>    some architectures. Does it make sense to remove
>    these variables from the kernel source?
>
>Perhaps your copy of grep is buggy, check out
>fs/proc/array.c which does make use of those macros.
>




_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com

