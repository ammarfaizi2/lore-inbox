Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267846AbUHUUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267846AbUHUUqK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267859AbUHUUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 16:46:09 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:5268 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S267846AbUHUUpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 16:45:39 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	<873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	<87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com>
	<1092729140.9539.129.camel@gaston> <87k6vytbjo.fsf@dedasys.com>
	<1092732749.10506.151.camel@gaston> <87isbh6hxd.fsf@dedasys.com>
From: davidw@dedasys.com (David N. Welton)
Date: 21 Aug 2004 22:42:51 +0200
In-Reply-To: <87isbh6hxd.fsf@dedasys.com>
Message-ID: <871xi0te7o.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidw@dedasys.com (David N. Welton) writes:

> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > > 2.6.6 sleeps/wakes just fine.  I had a halfhearted look through
> > > the 7 2.6.patch, searching on things like 'ppc' and 'macintosh',
> > > but didn't 2.6.see much that jumped out at me.
> 
> > Best would be if you could try the various 2.6.7-rc patches ...
> 
>  .... patching, compiling ....
> 
> rc1 sleeps/wakes, rc2 does not.

The only thing that jumps out at me is that arch/ppc/mm/cachemap.c
'moved' to arch/ppc/kernel/dma-mapping.c and seems to have changed
some as well.  Other than that, I would need more suggestions for
debugging.

Thankyou,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
