Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267528AbUIJQXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267528AbUIJQXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267543AbUIJQUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:20:16 -0400
Received: from pegasus.allegientsystems.com ([208.251.178.236]:55822 "EHLO
	pegasus.lawaudit.com") by vger.kernel.org with ESMTP
	id S267528AbUIJQTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:19:38 -0400
Message-ID: <4141D415.6050705@optonline.net>
Date: Fri, 10 Sep 2004 12:19:33 -0400
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040806
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain> <593560000.1094826651@[10.10.2.4]> <chsivd$827$1@sea.gmane.org>
In-Reply-To: <chsivd$827$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander E. Patrakov wrote:
> Martin J. Bligh wrote:
> 
>> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Friday, September 10, 
>> 2004 10:14:11 +0100):
>>
>>> Its probably appropriate to drop gcc 2.x support at that point too since
>>> it's the major cause of remaining problems
>>
>>
>> What problems does it cause? 2.95.4 still seems to work fine for me.
> 
> 
> The latest gcc2 on the ftp.gnu.org site is gcc 2.95.3. There is 
> officially no such thing as "gcc 2.95.4". Probably you are talking about 
> a patched version of some gcc2 cvs snapshot - that's what distros 
> provide. Please specify exactly what gcc version you are talking about.

2.95.4, if I remember correctly, contained fixes that went onto the gcc 
2.95 branch after 2.95.3 was released. Some of the fixes were for 
Linux-2.2/2.4 and glibc2.2 compatibility. This compiler was distributed 
by Debian, I think.

> 
> And there _is_ problem with gcc-2.95.3-compiled kernel: latest cvs glibc 
> testsuite segfaults in nptl tests. There are no failures with the kernel 
> identically configured, but compiled with gcc 3.3.4 or 3.4.1. So gcc 
> 2.95.3 as supplied by gnu.org miscompiles the kernel (futexes?). Either 
> fix the kernel or drop gcc2 support.
> 

