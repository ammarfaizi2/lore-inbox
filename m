Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFH02>; Mon, 6 Nov 2000 02:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKFH0R>; Mon, 6 Nov 2000 02:26:17 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:43272 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129117AbQKFH0I>;
	Mon, 6 Nov 2000 02:26:08 -0500
Message-ID: <3A065CDD.BF15B3AC@mandrakesoft.com>
Date: Mon, 06 Nov 2000 02:25:17 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.21.0011060715431.14068-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Mon, 6 Nov 2000, Oliver Xymoron wrote:
> 
> > Hopefully not. The standard examples (mixer levels, etc) are better
> > handled with a userspace tool hooked by modprobe. This even gets
> > persistence across reboots if that's what's wanted.
> 
> Implement a way for a userspace tool to get the correct mixer levels in
> place at the time the sound hardware is reset, so there are no glitches in
> the levels, and I'll agree with you.

Linux-Mandrake's initscripts run aumix on bootup and shutdown, to take
care of this...

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
