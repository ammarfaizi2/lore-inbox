Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269913AbRHED5I>; Sat, 4 Aug 2001 23:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269912AbRHED46>; Sat, 4 Aug 2001 23:56:58 -0400
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:15488 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S269913AbRHED4q>; Sat, 4 Aug 2001 23:56:46 -0400
Message-ID: <3B6CC309.541FA10@randomlogic.com>
Date: Sat, 04 Aug 2001 20:52:41 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
CC: modegard@akamai.com
Subject: Re: Dual Athlon, AGP, and PCI
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just an update as to progress with this dual Athlon.

I've managed to find time around a hectic work schedule to get IDE
and
AGP support working. hadparm -v  right after boot shows DMA enabled.
hdparm -t now produces 35.89MB/sec (consistently) as compared to 2.5
previously. This is also a full 10MB/sec. better than I had
previously
after tweaking the IDE settings with hdparm after booting.

AGP is working with both the agpgart driver and the NVidia driver,
but
FW still does not. I have not spent much time on this though.

I need to do some more testing, etc. before I submit any code
changes
(and it might be a good ide if I upgraded to one of the latest
releases/patches as well).

PGA
-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
