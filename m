Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbRGJTPj>; Tue, 10 Jul 2001 15:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267105AbRGJTPS>; Tue, 10 Jul 2001 15:15:18 -0400
Received: from [194.213.32.142] ([194.213.32.142]:4868 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S267103AbRGJTPL>;
	Tue, 10 Jul 2001 15:15:11 -0400
Message-ID: <20010710010505.C557@bug.ucw.cz>
Date: Tue, 10 Jul 2001 01:05:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>,
        Helge Hafting <helgehaf@idb.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <3B442354.BCA61010@idb.hist.no> <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.33.0107050810400.22053-100000@penguin.transmeta.com>; from Linus Torvalds on Thu, Jul 05, 2001 at 08:17:04AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > But please don't make initrd mandatory for those of us who don't
> > need ACPI, don't need dhcp before mounting disks and so on.
> 
> You would never even know the difference. You'd do a "make bzImage", and
> the default filesystem would just be embedded into the image. By default
> it probably doesn't need to do much - although things like the BIOS DPMI
> scan etc would surely be good to get rid of.
> 
> Why complain about that?

I'm afraid it will make bzImage way bigger. And making bzImage build
dependend on libc is not nice... Or are you going with "userspace but
no libc" way? That would solve size, but such userspace
is... well.. not too different from kernel space ;-).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
