Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVE3ODr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVE3ODr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVE3ODr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:03:47 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:25607 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261605AbVE3ODp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:03:45 -0400
Message-ID: <429B1DBF.1060205@snapgear.com>
Date: Tue, 31 May 2005 00:05:51 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH : ppp + big-endian = kernel crash
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak () muc ! de> writes:
> Andrew Morton <akpm@osdl.org> writes:
>>> 
>>> So many variants of tunneling and protocol encapsulation can result in
>>> unaligned packet headers, and as a result platforms really must
>>> provide proper unaligned memory access handling in kernel mode in
>>> order to use the networking fully.
>>
>> As Philippe mentioned, old 68k's simply cannot do this.
> 
> An 68000 cannot, but 68010+ can. Are there really that many 68000 users
> left? 

Probably not of the 68000 as such, but the "new" generation of
68000 parts, Motorola/Freescales ColdFire family. There is quite
a few of them, used in all sorts of embedded applications.
And they are still churning out new varients of it. The majority
of them are MMUless - but not all.

Regards
Greg

