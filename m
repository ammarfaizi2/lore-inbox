Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266489AbUFUWGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUFUWGy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUFUWGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:06:53 -0400
Received: from mailsrv1.tranzpeer.net ([202.180.66.207]:2273 "EHLO
	mailsrv1.tranzpeer.net") by vger.kernel.org with ESMTP
	id S266489AbUFUWGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:06:50 -0400
Message-ID: <40D74DA3.4080106@flying-brick.caverock.net.nz>
Date: Mon, 21 Jun 2004 22:05:40 +0100
From: The Viking <viking@flying-brick.caverock.net.nz>
Organization: The Flying Brick System
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: viking@flying-brick.caverock.net.nz
Subject: [Fwd: Re: gcc3.3.2, kernel-2.6.6, and Mandrake 10.0 compiling problem.]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Does this happen randomly, not in the same place each time?
> If yes, this usually happens with flakey hardware.
> I had this problem just yesterday. My box survives memtest86
> and cpuburn, yet gcc segfaults within minute or two.
> Relaxing DDR timing (Trcd: 2->3) eliminated segvs.
> 
> OTOH, note that there exist K6's with nasty bug:
> in some very rare circumstances (you have to have more than 32MB or RAM,
> you must modify data lying exactly N*32MB away from your current
> instruction pointer, etc...) CPU erroneously execute an instruction
> twice. As you can imagine, that will make your computer very unhappy.

As I said, I've done all of that. My guess is: it's not a hardware problem, it 
seems to be consistently at exactly the same place every single time.
I have no way of measuring whether my compiler modifies data exactly Nx32Mb 
away...and as I have 192Mb, I don't know if that's even the fault, though I've 
got a K6-II@500MHz (running at 533MHz, more stable that way- keeps behaving 
strangely at 500MHz)
I'm still scratching my head about it, frankly. I finally found my local 
Mandrake kernel source tree, so I'll see if the toolchain even builds that. If 
it doesn't, then I'll have to hunt in other areas for answers.

Cheers, and thanks for your comments.
The Viking
