Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTJVPrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 11:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbTJVPrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 11:47:36 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:44504 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263461AbTJVPrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 11:47:35 -0400
Date: Wed, 22 Oct 2003 08:47:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Meelis Roos <mroos@math.ut.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC & 2.6.0-test3: wrong mem size & hang on ifconfig
Message-ID: <20031022154734.GC19915@ip68-0-152-218.tc.ph.cox.net>
References: <20031020203338.GJ6062@ip68-0-152-218.tc.ph.cox.net> <Pine.GSO.4.44.0310221830260.21711-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310221830260.21711-100000@math.ut.ee>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 22, 2003 at 06:31:35PM +0300, Meelis Roos wrote:
> > Okay.  Can you give the linuxppc-2.5 repo a shot on this machine?  It's
> > at bk://ppc.bkbits.net/linuxppc-2.5 and
> > rsync://source.mvista.com/linuxppc-2.5, for reference.  Let me know if
> > it still boots at least and if it finds 64MB of memory again, it
> > should..
> 
> It boots, tells the avail ram is 00400000 00800000 (should be 64M?)

Nope, that's the bootwrapper, not the kernel.

> and then the kernel hangs after starting Linux.

Odd, okay.  I've heard similar reports with the 2.4 version of the code,
so I'll let you know when I think it might be fixed.

-- 
Tom Rini
http://gate.crashing.org/~trini/
