Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266745AbUGUVwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266745AbUGUVwL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266747AbUGUVwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:52:11 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:23766 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S266745AbUGUVwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:52:03 -0400
Message-ID: <40FEE582.9020200@nsr500.net>
Date: Wed, 21 Jul 2004 14:52:02 -0700
From: Tim Moore <linux-kernel@nsr500.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.26 oops
References: <20040721145900.9878.69804.Mailman@linux.us.dell.com>
In-Reply-To: <20040721145900.9878.69804.Mailman@linux.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Santoro wrote:
> H/W: asus p3b-f, 1GB ecc ram, 1.4 Ghz tualatin celeron (no overclocking)

What slocket are you using?  Is it set to "auto"?
What are the CPU/FSB/PCIbus/memory BIOS settings?
Have you tried recompiling with CONFIG_M686=y?
Have you tried turning ECC off?
Are you paging a lot or running out of swap?

t.

> S/W: slackware 9.1 with updates, kernel 2.4.26
> 
> System was running fine for almost 4 years (originally was P3 600E, 
> upgraded to tualatin 1+ yr ago).  Prior to getting these 2.4.26 oops, I 
> got random 2.4.26 lockups and reboots (usually using mouse in X) with 
> nothing on my screen or in my logs.  I decided to install a new Antec 
> Truepower 430W psu, but the problems remained.  Antec tech support told 
> me that my new psu was not within spec, so they replaced it.  I'm now 
> running with the replaced Antec Truepower 430 psu and getting a 2.4.26 
> oops (usually happens when selecting a newsgroup via mouse in mozilla 
> 1.7).  I suppose I could have a H/W problem, but just in case it's a 
> valid kernel problem, I'm submitting this email.
> 
> Any help is appreciated.
> 
> 
> Thank you,
> 
> 
> Peter Santoro
> 
> =============== FROM SYSLOG ============
> 
> ksymoops 2.4.9 on i686 2.4.26.  Options used
>       -v /usr/src/linux/vmlinux (specified)
>       -k /proc/ksyms (default)
>       -l /proc/modules (default)
>       -o /lib/modules/2.4.26/ (default)
>       -m /usr/src/linux/System.map (default)
> 
> kernel BUG at page_alloc.c:103!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0134346>]    Not tainted
> ...
> 

-- 
  | for direct mail add "private_" in front of user name
