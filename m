Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUCZVke (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 16:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUCZVke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 16:40:34 -0500
Received: from mail.timesys.com ([65.117.135.102]:34260 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261273AbUCZVk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 16:40:29 -0500
Message-ID: <4064A34C.9050506@timesys.com>
Date: Fri, 26 Mar 2004 16:40:28 -0500
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-ppc/elf.h warning
References: <Pine.GSO.4.44.0403261956350.2460-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0403261956350.2460-100000@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2004 21:31:44.0484 (UTC) FILETIME=[BC547A40:01C41379]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:

>>Can you try just removing <linux/elf.h> from everything in
>>arch/ppc/boot/ ?
>>    
>>
>
>elf.h include is present in arch/ppc/boot/simple/misc.c and
>arch/ppc/boot/simple/misc-embedded.c. The first one caused my warning
>and the include can be safely removed from there. The other file is not
>used in my config (prep) but I did try to compile it with elf.h include
>removed (make arch/ppc/boot/simple/misc-embedded.o) and it failed. So
>here is the patch against arch/ppc/boot/simple/misc.c. Nevertheless,
>asm-ppc/elf.h can not be included by itself without a warning about
>struct task_struct - is this a problem or not?
>  
>
I checked and I simply removed it when building for an ep8260. What 
board still needs it?

Greg Weeks
