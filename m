Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAEPIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAEPIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 10:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWAEPIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 10:08:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:29678 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1750746AbWAEPIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 10:08:43 -0500
Subject: Re: 2.6.15-rt1-sr1: xfs mount crash
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vegard Lima <Vegard.Lima@hia.no>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0601050830120.9377@gandalf.stny.rr.com>
References: <1136467202.2310.10.camel@tordenfugl.lima.heim>
	 <Pine.LNX.4.58.0601050830120.9377@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 07:08:41 -0800
Message-Id: <1136473721.31011.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 08:38 -0500, Steven Rostedt wrote:

> Hi Vergard,
> 
> I just want to make sure I understand the above.
> 
> The bug happens when CONFIG_DEBUG_RT_LOCKING_MODE is _not_ set?
> 
> And the bug goes away when it _is_ set?


Looks like a race , so maybe a timing issue. Just turn on some debugging
in the code path that slows/speeds things just enough . 

Daniel

