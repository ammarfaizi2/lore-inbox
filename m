Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268145AbUHQIb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268145AbUHQIb7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268160AbUHQIb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 04:31:59 -0400
Received: from host4-67.pool80117.interbusiness.it ([80.117.67.4]:17536 "EHLO
	dedasys.com") by vger.kernel.org with ESMTP id S268145AbUHQI2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 04:28:51 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>, j.s@lmu.de,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 (or 7?) regression: sleep on older tibooks broken
References: <873c2ohjrv.fsf@dedasys.com> <1092569364.9539.16.camel@gaston>
	<873c2n41hs.fsf@dedasys.com> <1092668911.9539.55.camel@gaston>
	<87llgfdqb7.fsf@dedasys.com> <874qn353on.fsf@dedasys.com>
	<1092729140.9539.129.camel@gaston>
From: davidw@dedasys.com (David N. Welton)
Date: 17 Aug 2004 10:26:51 +0200
In-Reply-To: <1092729140.9539.129.camel@gaston>
Message-ID: <87k6vytbjo.fsf@dedasys.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Tue, 2004-08-17 at 04:38, David N. Welton wrote:
> > davidw@dedasys.com (David N. Welton) writes:

> > > If it's useful, I suppose I can try backing of to 2.6.7 to see
> > > if it suffers from the same problem...

> > 2.6.7 is also broken.  Fresh 2.6.7 compiled, and it doesn't work
> > either.

> Can you try going backward in time find when it broke ?

2.6.6 sleeps/wakes just fine.  I had a halfhearted look through the 7
2.6.patch, searching on things like 'ppc' and 'macintosh', but didn't
2.6.see much that jumped out at me.

Thanks,
-- 
David N. Welton
     Personal: http://www.dedasys.com/davidw/
Free Software: http://www.dedasys.com/freesoftware/
   Apache Tcl: http://tcl.apache.org/
       Photos: http://www.dedasys.com/photos/
