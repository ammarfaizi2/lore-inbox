Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbULSQUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbULSQUT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 11:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbULSQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 11:20:19 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:2192 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261302AbULSQUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 11:20:14 -0500
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with
	workaround...
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200412172242.iBHMgVav003005@turing-police.cc.vt.edu>
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
	 <1103300362.12664.53.camel@localhost.localdomain>
	 <1103303011.12664.58.camel@localhost.localdomain>
	 <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu>
	 <1103313861.12664.71.camel@localhost.localdomain>
	 <1103320354.3538.11.camel@localhost.localdomain>
	 <200412172242.iBHMgVav003005@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 19 Dec 2004 11:20:03 -0500
Message-Id: <1103473203.4143.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-17 at 17:42 -0500, Valdis.Kletnieks@vt.edu wrote:

> Most likely, the fact you have SMP/HT and I'm just on a PREEMPT-UP kernel is
> what's making the difference.  There's almost certainly a '#ifdef CONFIG_SMP'
> involved here somehow....

Yep! I just compiled my system without SMP and I was able to start up X
with NVidia on my HT laptop (with V0.7.33-04).  

Ingo, do you think this is a bug with NVidia (bad proprietary module) or
might be with something in the RT SMP side? I'll look a little more on
Monday, but if you know of something, let me know.  I'm curious to why
it works fine without RT but will not work with RT (and SMP). I
shouldn't say NVidia bug, since it only is a problem with the RT SMP, so
I should say incompatibility w.r.t. RT SMP and NVidia.

If you are one of those that don't want anything to do with the NVidia
driver, and don't care less if it works or not, let me know that too.
That way I won't bother you with this anymore and will only communicate
with Valdis :-)


Thanks,

-- Steve


