Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbRAEG7Q>; Fri, 5 Jan 2001 01:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbRAEG7G>; Fri, 5 Jan 2001 01:59:06 -0500
Received: from 209.102.21.2 ([209.102.21.2]:37391 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129610AbRAEG6v>;
	Fri, 5 Jan 2001 01:58:51 -0500
Message-ID: <3A55403C.39E4A48B@goingware.com>
Date: Fri, 05 Jan 2001 03:32:12 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested, I added:

apm=power-off

to the kernel line of my grub menu.lst file and now I can power off. I almost
jumped when the machine snapped off - my bloody monitor doesn't go dark when it
loses signal it lights up with an RGB test pattern (TTX - don't buy one).

I think the real reason it wasn't working was that, although I'm using a
one-processor machine with a motherboard that only allows for one processor, I
had enabled SMP in the kernel, and this disables APM.

In my own work I mostly do multithreaded software development and I just sort of
felt like it would be good karma to enable it even if my machine didn't support
it.  Go figure.  So this was mostly a user error, although I guess I've been
helpful in discovering the current interaction of ACPI and APM.

I'll read up a bit more on ACPI and see what I can do with that later on.

Thanks for the help.  If you're in the neighborhood, stop by:

http://linuxquality.sunsite.dk

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
