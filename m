Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWCGUhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWCGUhc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWCGUhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:37:32 -0500
Received: from dvhart.com ([64.146.134.43]:40367 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751098AbWCGUhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:37:32 -0500
Message-ID: <440DEF0A.3030701@mbligh.org>
Date: Tue, 07 Mar 2006 12:37:30 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
References: <20060307021929.754329c9.akpm@osdl.org>
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm3/
> 
> - A relatively small number of changes, although we're up to 9MB of diff
>   in the various git trees.

E_NOT_COMPILING ;-) i386+NUMA at least

NUMA-Q + 
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq
=
http://test.kernel.org/24793/debug/test.log.0
mm/built-in.o(.text+0x178dc): In function `check_huge_range':
mm/mempolicy.c:1832: undefined reference to `huge_pte_offset'
make: *** [.tmp_vmlinux1] Error 1
03/07/06-12:25:56 Build the kernel. Failed rc = 2
03/07/06-12:25:56 build: kernel build Failed rc = 1
03/07/06-12:25:56 command complete: (2) rc=126

Much the same error on x440 +
http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
=
http://test.kernel.org/24791/debug/test.log.0
