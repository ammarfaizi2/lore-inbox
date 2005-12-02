Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVLBAqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVLBAqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVLBAqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:46:35 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3805 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932502AbVLBAqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:46:34 -0500
Date: Fri, 2 Dec 2005 01:46:14 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rmk+lkml@arm.linux.org.uk, ray-gmail@madrabbit.org, tglx@linutronix.de,
       linux-kernel@vger.kernel.org, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
Message-ID: <Pine.LNX.4.61.0512020129590.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
 <Pine.LNX.4.61.0512011352590.1609@scrub.home>
 <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com>
 <20051201165144.GC31551@flint.arm.linux.org.uk> <20051201122455.4546d1da.akpm@osdl.org>
 <20051201211933.GA25142@elte.hu> <20051201135139.3d1c10df.akpm@osdl.org>
 <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 1 Dec 2005, Kyle Moffett wrote:

> A timeout (like waiting for somebody to answer the phone) is optimized to
> never happen (they will hopefully pick up first).  If everything works
> perfectly; it will be stopped before it has a chance to go off.
> 
> A timer (like a kitchen timer telling you the cookies are done) is optimized
> to be added and sit around until it expires.  You just don't turn off the
> timer and take the cookies out before they are done.

Making this the primary criteria for choosing a timer system would be a
huge mistake. As I wrote in a previous mail there are other, more 
important criteria.
So far I still thought this was about kernel programming and not about 
Aunt Tillies cooking show. Can we please bring this back to a technical 
level?

bye, Roman
