Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUHVFv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUHVFv6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 01:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266223AbUHVFv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 01:51:57 -0400
Received: from host-64-71-93-144.dhcp.milfordcable.net ([64.71.93.144]:64641
	"EHLO windeath.2y.net") by vger.kernel.org with ESMTP
	id S266220AbUHVFv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 01:51:56 -0400
Message-ID: <4128349B.7050304@windeath.2y.net>
Date: Sun, 22 Aug 2004 00:52:27 -0500
From: "James M." <dart@windeath.2y.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040803)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
References: <2vOfA-7Vg-7@gated-at.bofh.it> <m34qmwx8nv.fsf@averell.firstfloor.org>
In-Reply-To: <m34qmwx8nv.fsf@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Then perhaps the code should be removed or at least explain in the help 
why it can't be selected...do you have a preference?

Does having this disabled confuse apps like Mplayer who detect the cpu 
and expect it to be there? I'm guessing the kernel handles it correctly 
but I'm just curious.

Andi Kleen wrote:
> "James M." writes:
> 
> 
>>Title says it...my Athlon 64 definitely uses 3DNOW. Patch changes
>>arch/i386/Kconfig and has a 3 line fudge factor(I created it a few
>>kernels back). Might want to check other arches for the same bug.
> 
> 
> It it's not a bug, it is a feature. The K8 is better off not using 
> the 3dnow memcpy, which is the only feature this CONFIG controls.
> 
> Please don't apply.
> 
> -Andi
> 
