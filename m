Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313968AbSDFETR>; Fri, 5 Apr 2002 23:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313969AbSDFETH>; Fri, 5 Apr 2002 23:19:07 -0500
Received: from mail.gmx.de ([213.165.64.20]:34059 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313968AbSDFESt>;
	Fri, 5 Apr 2002 23:18:49 -0500
Date: Sat, 6 Apr 2002 13:46:40 +0930
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel panic
Message-ID: <20020406041640.GA451@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Daniel Mundy <djmunds@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Lately I am having kernel panic's, and I have no idea why.. I have not changed anything lately except for regular
software updates. I am using Debian Woody 3.0, packages updated daily, with a 2.4.18 kernel. I have not noticed any
pattern in occurance, the other day it happened just after I dialed my ISP, about 20 minutes ago I was simply using
vim from my windows box via ssh, and just now I had it freeze again after typing `vim .<tab>`..

I also noticed that on reboot, it presents me with "(none) login:" rather than using my hostname of xion as per
usual.. an `ifconfig` shows nothing, ifconfig simply lists lo, and no eth0. Another reboot fixes this. This has only
happened once, I just had another kernel panic and this time on reboot my network is fine, so I am not sure whether
this is related.

These are the messages I see on my terminal, I cannot see any more as this is the highest mode my monitor can support:

-------------------------
<1>Unable to handle kernel NULL pointer deference at virtual address 00000000
 printing eip:
000000
*pde = 000000
Oops: 0000
CPU:   0
EIP:   0010:[<00000000>]   Tainted: P
EFLAGS: 00010246
eax: 00000000   ebx: c6af3b40   ecx: c52df1eo   edx: 00000014
esi: c6af3c78   edi: c6d530bc   ebp: c6af3c78   esp: c030dd9c
ds: 0018   es: 0018   ss: 0018
Process Swapper (pid: 0, stackpage=c030d000)
Stack: c02636oe c6af3b40 c6d530bc 00000014 c52df1e0 61f6f8a5 c6af3b40 c52df640
(more lines of this, my monitor is almost dead so was hard to read, if it is needed though I can find it out the next
time this problem occurs)
Call Trace: [<c026360e>] [<c0265bd6>] (etc, see above)

Code: Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
-------------------------

I asked around a bit on IRC and it was suggested I try asking here as this seems a kernel related problem. Thanks for
any help you can offer, if any more information about my situation is required let me know.

Regards,
Daniel Mundy
