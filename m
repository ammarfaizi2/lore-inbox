Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTDWWSC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 18:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264230AbTDWWSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 18:18:02 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:30865 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263631AbTDWWR6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 18:17:58 -0400
Date: Thu, 24 Apr 2003 10:25:25 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030423223639.7cc6a796.gigerstyle@gmx.ch>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1051136725.4439.5.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030423135100.GA320@elf.ucw.cz>
 <Pine.GSO.4.21.0304231631560.1343-100000@vervain.sonytel.be>
 <20030423144705.GA2823@elf.ucw.cz> <20030423175629.7cfc9087.gigerstyle@gmx.ch>
 <1051126871.1893.35.camel@laptop-linux>
 <20030423223639.7cc6a796.gigerstyle@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2003-04-24 at 08:36, Marc Giger wrote:
> Ok! I see the advantages / disadvantages of each version. But what
> happens if the memory AND swap space are full and nothing can't be
> freed? When I watch the memory and swap consumption on my laptop, I
> think it's the most time the case...

If you're getting yourself in that situation, you should be increasing
your swap space (and memory if possible) anyway.

> Another question:
> Is it a big problem to save the memory in a separate file on the file
> system, and save somewhere the pointer to it (as example in swap. Also
> we could set a flag in swap so that we now that the last shutdown was
> a hybernation). One Problem will be, that we don't know the filesystem
> type on resume...(We could save the module in swap...)
> All that is just theoretical. It's only a idea.

I guess the simplest answer is would it be worth the pain? Since disk
space is cheap, it just requires a little forethought when installing
Linux, to ensure enough swap is allocated. I certainly understand that
using a file rather than swap makes adjusting the amount of space
available easier, but as you rightly acknowledge, it does complicate
things a fair bit more.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

