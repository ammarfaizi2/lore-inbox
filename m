Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132210AbRAJMdA>; Wed, 10 Jan 2001 07:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135466AbRAJMcu>; Wed, 10 Jan 2001 07:32:50 -0500
Received: from [172.16.18.67] ([172.16.18.67]:15488 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132210AbRAJMcj>; Wed, 10 Jan 2001 07:32:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org> 
In-Reply-To: <Pine.LNX.4.31.0101091640470.21522-100000@q.dyndns.org> 
To: Benson Chow <blc@q.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Keyboards for x86/uhci in 2.4- kernels? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 12:32:19 +0000
Message-ID: <25542.979129939@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


blc@q.dyndns.org said:
>   In BIOS my USB keyboard works really poorly - it almost seems
> scancodes get dropped left and right.  Ok, so I don't mind too much,
> i'm sure BIOS has a very limited driver.  After booting Microsoft's
> offerring, it would work fine after it installs its driver. I also
> tried this same keyboard on a HPUX Visualize C3600 workstation and it
> also works nicely.

> However linux would never fix  this "scancode drop" syndrome even
> after loading the hid or usbkbd driver. 

I'm using a USB keyboard (on x86/uhci) without too much trouble.
 
Occasionally I seem to miss a key release event, causing the thing to 
autorepeat until I hit the key and release it again.

Also, the behaviour on pressing multiple keys simultaneously seems to be 
strange - 'grep' tends to come out as 'grerp' and 'mount' as 'mouunt' if I 
type them fast enough. That may simply be the keyboard's fault though.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
