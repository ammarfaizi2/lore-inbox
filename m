Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBILsm>; Fri, 9 Feb 2001 06:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129396AbRBILse>; Fri, 9 Feb 2001 06:48:34 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:5393 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129027AbRBILsN>;
	Fri, 9 Feb 2001 06:48:13 -0500
Message-ID: <3A83D8EE.8090500@megapathdsl.net>
Date: Fri, 09 Feb 2001 03:47:58 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-pre2 i686; en-US; m18) Gecko/20010207
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <Werner.Almesberger@epfl.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <3A83B6B0.8261F3CF@idb.hist.no> <3A83C4A1.5090903@megapathdsl.net> <20010209123640.B17129@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:

> Miles Lane wrote:
> 
>> Since, as Christophe mentions, the boot messages would
>> still be accessible via CTRL-ALT-F2, I don't see what 
>> the problem is with at least making this an option.
> 
> 
> Except if some initialization hangs your machine so badly that it even
> won't respond to Ctrl-Alt-F2.
> 
> This could of course be cured by a little window where the last three or
> four printk lines are shown ...

Actually, this is the best reason I've heard for not including
this "prettyfication" functionality at all.  Obviously, we
_do_ want people to be able to collect a complete OOPS.

I suppose perhaps an even more useful tweak to the this
idea would be that if the user holds down a special key
during the start of boot, the whole prettyfication stuff
isn't used and the VT number 1 gets all the boot messages.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
