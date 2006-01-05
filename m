Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWAEOOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWAEOOz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWAEOOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:14:55 -0500
Received: from mail48.e.nsc.no ([193.213.115.48]:30849 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1751270AbWAEOOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:14:55 -0500
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
From: Vegard Lima <Vegard.Lima@hia.no>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0601050830120.9377@gandalf.stny.rr.com>
References: <1136467202.2310.10.camel@tordenfugl.lima.heim>
	 <Pine.LNX.4.58.0601050830120.9377@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 15:16:02 +0100
Message-Id: <1136470562.2310.13.camel@tordenfugl.lima.heim>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 05.01.2006 Klokka 08:38 (-0500) skreiv Steven Rostedt:
> On Thu, 5 Jan 2006, Vegard Lima wrote:
> > I still get an Oops when mounting an XFS filesystem under 2.6.15-rt1-sr1
> > (Same happend for 2.6.15-rc7-rt1: http://lkml.org/lkml/2005/12/29/67 )
> >
> > I can make the Oops go away by changing this config option from
> >   # CONFIG_DEBUG_RT_LOCKING_MODE is not set
> > to
> >   CONFIG_DEBUG_RT_LOCKING_MODE=y
>
> I just want to make sure I understand the above.
> 
> The bug happens when CONFIG_DEBUG_RT_LOCKING_MODE is _not_ set?
> 
> And the bug goes away when it _is_ set?

Hi Steven,

that is correct.

Thanks,
-- 
Vegard Lima <Vegard.Lima@hia.no>

