Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269079AbTBZWwz>; Wed, 26 Feb 2003 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269126AbTBZWwz>; Wed, 26 Feb 2003 17:52:55 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269079AbTBZWwy>;
	Wed, 26 Feb 2003 17:52:54 -0500
Subject: Re: 2.5.62-mjb3 (scalability / NUMA patchset)
From: Mark Haverkamp <markh@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <4140000.1046300025@[10.10.2.4]>
References: <6490000.1045713212@[10.10.2.4]>
	 <16170000.1046110132@[10.10.2.4]>
	 <1046273777.1913.6.camel@markh1.pdx.osdl.net>
	 <3090000.1046274931@[10.10.2.4]>
	 <1046299742.3375.3.camel@markh1.pdx.osdl.net>
	 <4140000.1046300025@[10.10.2.4]>
Content-Type: text/plain
Organization: 
Message-Id: <1046300601.3375.13.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Feb 2003 15:03:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-26 at 14:53, Martin J. Bligh wrote:
> > I turned on NMI watchdogs and when the system hung, I saw no output.  My
> > serial console is through a terminal server that isn't set up to pass
> > along the sysrq, so I need to get this fixed.  In any case I backed out
> > the patch that you suggested and I have had no system hangs since.
> 
> OK, I'll back out that patch for now, but it seems to indicate underlying
> crud. What parameter did you set for NMI watchdog?

I set it to 1. In Documentation/nmi_watchdog.txt this looked like the
only option.  Now that I look at apic.h, I see that I could set it to 2
also. If you like I can try this also.

Mark.
-- 
Mark Haverkamp <markh@osdl.org>

