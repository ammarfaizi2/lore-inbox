Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129054AbQJ0OZy>; Fri, 27 Oct 2000 10:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129071AbQJ0OZf>; Fri, 27 Oct 2000 10:25:35 -0400
Received: from mailhost.digitalselect.net ([209.136.236.13]:39431 "EHLO
	mailhost.digitalselect.net") by vger.kernel.org with ESMTP
	id <S129054AbQJ0OZc>; Fri, 27 Oct 2000 10:25:32 -0400
Date: Fri, 27 Oct 2000 10:25:49 -0400
From: James Lewis Nance <jlnance@intrex.net>
To: linux-kernel@vger.kernel.org
Subject: Re: New VM problem
Message-ID: <20001027102549.A4272@bessie.dyndns.org>
In-Reply-To: <20001027070329.A884@bessie.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001027070329.A884@bessie.dyndns.org>; from jlnance@intrex.net on Fri, Oct 27, 2000 at 07:03:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 07:03:29AM -0400, James Lewis Nance wrote:

>     I left a single large job running when I left yesterday afternoon
> (size=1651M, RSS=1.5G).  When I got in this morning I wanted to see if
> it was still running so I typed "top" in an Xterm.  When I hit return I
> thought the machine had crashed.  I could not move the cursor with the
> mouse, or cause any other activity.

I got a little more info.  Even though the machine has 2G of ram and this
process'es RSS is only 1.5G, the rest of the memory is being used somewhere.
Top reports only about 1M as "free" memory.  It also looks like kswapd is
running with a high CPU usage when this is going on.  Its a little hard to
be sure since top freezes, but when it comes back to life kswapd shows up
near the top of the process list.

Thanks,

Jim
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
