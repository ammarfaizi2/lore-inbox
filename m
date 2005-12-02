Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932591AbVLBAg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbVLBAg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbVLBAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 19:36:29 -0500
Received: from smtpout.mac.com ([17.250.248.87]:27104 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932591AbVLBAg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 19:36:28 -0500
In-Reply-To: <1133481739.10478.54.camel@tglx.tec.linutronix.de>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com> <Pine.LNX.4.61.0512011352590.1609@scrub.home> <2c0942db0512010822x1ae20622obf224ce9728e83f8@mail.gmail.com> <20051201165144.GC31551@flint.arm.linux.org.uk> <20051201122455.4546d1da.akpm@osdl.org> <20051201211933.GA25142@elte.hu> <20051201135139.3d1c10df.akpm@osdl.org> <7D53372C-E138-4336-883F-A674BBBB09AA@mac.com> <20051201221553.GA19135@infradead.org> <1133481739.10478.54.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <537CE371-F9A9-4255-A3B0-9DBDAD82591B@mac.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, rmk+lkml@arm.linux.org.uk,
       ray-gmail@madrabbit.org, zippel@linux-m68k.org,
       linux-kernel@vger.kernel.org, george@mvista.com, johnstul@us.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Thu, 1 Dec 2005 19:36:22 -0500
To: tglx@linutronix.de
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 01, 2005, at 19:02, Thomas Gleixner wrote:
> On Thu, 2005-12-01 at 22:15 +0000, Christoph Hellwig wrote:
>> Heh, in my dumb non-native speaker mind I'd expectit the other way  
>> around, as in a timeout is expected to time out :)  and a timer is  
>> expect to happen, as in say the timer the tells you your breakfast  
>> egg is ready.
>
> Which is perfectly the point Kyle made.

In any case, the real important note here is that the two are pretty  
different concepts, ones that lend themselves to _very_ different  
optimizations, that are currently lumped together.  The very fact  
that some developers easily get them confused says that we need a  
good clean implementation of both distinct APIs with comparable  
documentation, including a bunch of good example usages.

Cheers,
Kyle Moffett

--
I have yet to see any problem, however complicated, which, when you  
looked at it in the right way, did not become still more complicated.
   -- Poul Anderson



