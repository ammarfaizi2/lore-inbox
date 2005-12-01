Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVLAWQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVLAWQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLAWQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:16:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7055 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932518AbVLAWQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:16:16 -0500
Date: Thu, 1 Dec 2005 22:15:53 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       rmk+lkml@arm.linux.org.uk, ray-gmail@madrabbit.org,
       zippel@linux-m68k.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
       george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
Message-ID: <20051201221553.GA19135@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
	ray-gmail@madrabbit.org, zippel@linux-m68k.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, george@mvista.com,
	johnstul@us.ibm.com
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <20051201122455.4546d1da.akpm@osdl.org> <20051201211933.GA25142@elte.hu> <20051201135139.3d1c10df.akpm@osdl.org> <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:13:17PM -0500, Kyle Moffett wrote:
> In this patch there are two ways of setting up code to run at some  
> point in the future: timers and timeouts.
> 
> A timeout (like waiting for somebody to answer the phone) is  
> optimized to never happen (they will hopefully pick up first).  If  
> everything works perfectly; it will be stopped before it has a chance  
> to go off.
> 
> A timer (like a kitchen timer telling you the cookies are done) is  
> optimized to be added and sit around until it expires.  You just  
> don't turn off the timer and take the cookies out before they are done.

Heh, in my dumb non-native speaker mind I'd expectit the other way around,
as in a timeout is expected to time out :)  and a timer is expect to happen,
as in say the timer the tells you your breakfast egg is ready.

