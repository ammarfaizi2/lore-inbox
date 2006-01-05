Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWAEVeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWAEVeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWAEVeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:34:05 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:10891 "EHLO mail42.e.nsc.no")
	by vger.kernel.org with ESMTP id S932226AbWAEVeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:34:04 -0500
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
From: Vegard Lima <Vegard.Lima@hia.no>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Daniel Walker <dwalker@mvista.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0601051618200.3110-100000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 22:34:27 +0100
Message-Id: <1136496867.12042.5.camel@tordenfugl.lima.heim>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 05.01.2006 Klokka 16:19 (+0100) skreiv Esben Nielsen:
> 
> On Thu, 5 Jan 2006, Daniel Walker wrote:
> >
> > Looks like a race , so maybe a timing issue. Just turn on some debugging
> > in the code path that slows/speeds things just enough .
> 
> CONFIG_DEBUG_RT_LOCKING_MODE turns spinlock_t into raw_spinlock_t again as
> far as I can see. It is probably some spinlock_t which has to be a
> raw_spinlock_t for the time being.

Just FYI 2.5.14-rt22 worked fine with
CONFIG_DEBUG_RT_LOCKING_MODE _not_ set.



Thanks,
-- 
Vegard Lima <Vegard.Lima@hia.no>

