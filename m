Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTJAEcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 00:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTJAEcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 00:32:48 -0400
Received: from law11-f67.law11.hotmail.com ([64.4.17.67]:24845 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261903AbTJAEco
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 00:32:44 -0400
X-Originating-IP: [202.164.101.164]
X-Originating-Email: [kartik_me@hotmail.com]
From: "kartikey bhatt" <kartik_me@hotmail.com>
To: paul@clubi.ie
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't X be elemenated?
Date: Wed, 01 Oct 2003 10:02:43 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F67ATnLE7P95L00001388@hotmail.com>
X-OriginalArrivalTime: 01 Oct 2003 04:32:43.0218 (UTC) FILETIME=[0E2DEB20:01C387D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey everyone who have joined this thread, my fundamental question have got
out of scope. I mean to say

1. Kernel level support for graphics device drivers.
2. On top of that, one can develop complete lightweight GUI.
3. Maybe kernel can provide support for event handling.

and I still stick to my opinion that graphics card is a computer resource
that needs to be managed by OS rather than 3rd party developers.
Just feeding in patches to provide support for AGP gart and DRI
is an adhoc solution, a stark immoral choice.
you don't know my frustration when i got PC and wasn't able to
run X until i810 agp gart support was available at kernel level.

And if you feel that I am a guy heavily dependent on X that's not true.
I just mean to say if anything is that kernel level support for graphics 
device drivers.
And X will be automatically eliminated.

and if you are feeling very unhappy about my statement X is bloat,
I really apologize for that.


>From: Paul Jakma <paul@clubi.ie>
>To: kartikey bhatt <kartik_me@hotmail.com>
>CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
>Subject: Re: Can't X be elemenated?
>Date: Tue, 30 Sep 2003 19:48:22 +0100 (IST)
>
>On Mon, 29 Sep 2003, kartikey bhatt wrote:
>
> > 1st. X is bloat.
>
>This isnt true.
>
>[paul@fogarty paul]$ cat /proc/`pidof X`/status | grep ^Vm
>VmSize:    47700 kB
>VmLck:         0 kB
>VmRSS:     22580 kB
>VmData:    25540 kB
>VmStk:        72 kB
>VmExe:      1488 kB
>VmLib:      1580 kB
>
>X is actually quite tiny, ~3MB of exe+lib. The data size is due,
>vastly, to the X /clients/ using the server (in the above case RH9
>GNOME + windowmaker + xchat2 + galeon + few xterms).
>
>Here's Xipaq (tinyX handheld X server):
>
>~ $  cat /proc/`pidof Xipaq`/status | grep ^Vm
>VmSize:     5072 kB
>VmLck:         0 kB
>VmRSS:      3164 kB
>VmData:     1788 kB
>VmStk:        16 kB
>VmExe:       848 kB
>VmLib:      2028 kB
>
>That's Xipaq, exe is smaller, but libs are bigger, balances out to
>~3MB again. However, the data segment is much smaller, < 2MB compared
>to > 25MB for the desktop case. The handheld runs the GPE
>(http://gpe.handhelds.org) environment.
>
>So perhaps you could come to the conclusion that 'X' (in the X server
>sense) is not bloat, but that the /clients/ on modern desktops are?
>
> > Though it's good for server environments. For desktop pcs it's too
> > heavy.
>
>You are misinformed. See above.
>
> > 2nd. It's process based client/server architecture is a bottleneck.
>
>Why do you think so? For large amounts of data, X clients can use
>shared memory. Further, even if they must transfer data (ie
>pixmaps/pics) across the socket connection, the X server can cache
>it, and the client can use it by reference. (ie a once off cost).
>
>Also, local X clients use unix sockets - blazingly fast.
>
> > It's not as interactive as is supposed to be.
>
>Have you tried 2.6.0-test6? The interactivity problems were the
>kernel's fault more than that of 'X'.
>
> > 3rd. Most important. I can't impress or convince my
> > window(crash)(TM) user friends, relatives (who saw X running on my
> > pc) to use Linux.
>
>You wont impress /anyone/ with "just X" (ie just the X server) -
>cause all you'll get is a tiled background of tiny X logos and an X
>mouse pointer.
>
> > 4th. I want to see desktop being ruled by Linux.
>
>"X" isnt the obstacle.
>
>To be able to constructively criticise something you first need to
>/understand/ it. You dont.
>
>Most of you what you complain about, bloat and heavyness, is due to
>the desktop environment - not X itself. Try running GPE
>(http://gpe.handhelds.org) or (easier/actually practical too for a
>desktop) Xfce (http://www.xfce.org)
>
>Finally, this isnt a kernel problem.
>
>regards,
>--
>Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
>	warning: do not ever send email to spam@dishone.st
>Fortune:
>Real wealth can only increase.
>		-- R. Buckminster Fuller
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
Get Married!  http://www.bharatmatrimony.com/cgi-bin/bmclicks1.cgi?74 Search 
from 7 lakh Brides & Grooms.

