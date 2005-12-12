Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbVLLKrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVLLKrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLLKrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:47:39 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:8835 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751223AbVLLKri
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:47:38 -0500
Message-ID: <439D5625.4030900@aitel.hist.no>
Date: Mon, 12 Dec 2005 11:51:17 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org> <20051210162759.GA15986@aitel.hist.no> <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512111607040.15597@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>Helge,
> did this start at any particular point in time?
>  
>
Not that I know of, flash games became popular the last weeks.
I can try some older kernels though.

>Also, the most common case is that somebody has reniced the X server, 
>which is just _wrong_.  
>
I wish it was that simple.  But according to "top", the xservers runs
with NI=0.  I believe I got rid of the X renicing at the time the scheduler
was improved.  Nobody played flash games at the time though.

I have tried running two tuxracers too, and found this to be somewhat
bursty.  Instead of the players enjoying half a cpu each (which
is bearable at sufficiently low resolution), they seem to get bursts of cpu
and short pauses.  I never bothered looking more into this as  the
pci card always hangs the machine after a while when doing 3D. Instead
I disabled DRI on that xserver.  Stability is more important.

Helge Hafting
