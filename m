Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSHGNHn>; Wed, 7 Aug 2002 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317214AbSHGNGk>; Wed, 7 Aug 2002 09:06:40 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47243 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317302AbSHGNGf>;
	Wed, 7 Aug 2002 09:06:35 -0400
Message-ID: <3D511382.BBC4D352@daimi.au.dk>
Date: Wed, 07 Aug 2002 14:33:06 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-ac1
References: <200208031859.g73IxiA09952@devserv.devel.redhat.com> <3D504C10.7975CCD8@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> I'm using 2.4.19-ac1 with patch-int-2.4.18.2. The system
> was running and heavily used for 2 days and 22 hours
> without a single glitch, but at shutdown I got an Oops
> from S01halt. I had no way to save the output, so I just
> wrote down the IP and calltrace, here is the output from
> ksymoops with that input:
> 
> Trace; c012c077 <kmem_cache_free+37/a0>
> Trace; c011df6c <free_uid+2c/30>
> Trace; c01188cc <release_task+2c/120>
> Trace; c0119746 <sys_wait4+2f6/380>
> Trace; c01089f3 <system_call+33/40>
> 
> I don't think it is related to the patch, which have
> been working flawlessly since 2.4.18. I don't know yet
> if the problem can be reproduced.

I have not been able to reproduce the problem, and I have
no idea what so ever about the cause. What I forgot to
mention in my previous mail was that this happened on a
UP system, and the Oops message was a kernel paging
request (at some 0xC... address AFAIR).

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
