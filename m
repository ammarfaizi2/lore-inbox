Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUFFXBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUFFXBA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 19:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUFFXA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 19:00:59 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25313 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S264218AbUFFW7K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 18:59:10 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Date: Sun, 6 Jun 2004 15:57:12 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH] Disable scheduler debugging
In-Reply-To: <40C3452B.5010500@pobox.com>
Message-ID: <Pine.LNX.4.60.0406061554370.11624@dlang.diginsite.com>
References: <20040606033238.4e7d72fc.ak@suse.de> <20040606055336.GA15350@elte.hu>
 <40C3452B.5010500@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jun 2004, Jeff Garzik wrote:

>
> Unfortunately there are just, flat-out, way too many kernel messages at 
> boot-up.  Making them KERN_DEBUG doesn't solve the fact that SMP boxes often 
> overflow the printk buffer before you boot up to a useful userland that can 
> record the dmesg.
>
> The IO-APIC code is a _major_ offender in this area, but the CPU code is 
> right up there as well.
>
neither of these are nearly as bad as the crypto code, it takes a HUGE 
kernel log to get any info from before that if you enable all the 
encryption modes.

David Lang


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
