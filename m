Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261796AbSJMUtd>; Sun, 13 Oct 2002 16:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261820AbSJMUtd>; Sun, 13 Oct 2002 16:49:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60913 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261796AbSJMUsX>;
	Sun, 13 Oct 2002 16:48:23 -0400
Date: Sun, 13 Oct 2002 13:49:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: James Simmons <jsimmons@infradead.org>, Anton Blanchard <anton@samba.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console changes 1
Message-ID: <40570000.1034542147@flay>
In-Reply-To: <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
References: <Pine.LNX.4.33.0210131338400.6800-100000@maxwell.earthlink.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Are you going to have early console support (ie printk from before
>> > what is now console_init) done before the freeze, or should I just
>> > submit our version?
>> 
>> On ppc64 Im currently setting a console up very early in arch init code
>> and using the CONFIG_EARLY_PRINTK hook to disable it at console_init
>> time. Works OK for me, do you guys need something on top of that?
> 
> Ugh!!! The reason I reworked the console system is because over the years
> hack after hack has been added. It now has lead to this twisted monster.
> Take a look at the fbdev driver codes in 2.4.X. Instead of another hack
> the console system should be cleaned up with a well thought out design to
> make the code base smaller and more effiencent.

Cool, as long as it gets merged by the freeze. We've been waiting for you 
to do this for a long time, but if it's not ready, then we need the hacky versions
in order to get the functionality.

M.

