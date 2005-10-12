Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbVJLUuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbVJLUuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 16:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbVJLUuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 16:50:09 -0400
Received: from qproxy.gmail.com ([72.14.204.206]:13664 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751546AbVJLUuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 16:50:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=P3gqUbxMDEXQoWXutJMM/Rz8nDXfvG7B9kXmJ3ed3VzqQVFMf0fy1OW/vVise3vY3wCYYtgLRwPRRuv+hAwD4AYI5Z6rjEERv/x+9noO9lQXgsXJXL/se1NmtxgFq4nKPXQ2qEP8eerYUuAMT+fNLpdscQijrv6BuBR6PLmT3wg=
Subject: Re: 2.6.14-rc4-rt1
From: Badari Pulavarty <pbadari@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051011111454.GA15504@elte.hu>
References: <20051011111454.GA15504@elte.hu>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 09:42:17 -0700
Message-Id: <1129135337.21743.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,


I am getting similar segfault on boot problem on 2.6.14-rc4-rt1
on my x86-64 box (with LATENCY_TRACE). 

Is there a resolution to this problem ?

Thanks,
Badari

EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
umount: devfs: not mounted
INIT: version 2.86 booting
hotplug[877]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffff8bee68 error 15
hotplug[878]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffb1a408 error 15
hotplug[879]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffff878408 error 15
hotplug[880]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffad36d8 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffc00b10 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffc003b8 error 15
rcS[882]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffff967428 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffc003b8 error 15
init[1]: segfault at ffffffff8010f588 rip ffffffff8010f588 rsp
00007fffffc003b8 error 15
</snip>

Thanks,
Badari

