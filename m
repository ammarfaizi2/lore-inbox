Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWFKG0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWFKG0v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932575AbWFKG0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:26:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22672 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932572AbWFKG0u
	(ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Sun, 11 Jun 2006 02:26:50 -0400
From: Darren Hart <dvhltc@us.ibm.com>
Organization: IBM Linux Technology Center
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC PATCH -rt] Priority preemption latency
Date: Sat, 10 Jun 2006 23:24:58 -0700
User-Agent: KMail/1.9.1
Cc: linux-kerneL@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <200606091701.55185.dvhltc@us.ibm.com> <20060610064850.GA11002@elte.hu> <200606102249.26063.dvhltc@us.ibm.com>
In-Reply-To: <200606102249.26063.dvhltc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606102324.58932.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the updated patch!  It wouldn't quite build (proc_misc.c still
> referenced the old rt_overload_* variables, fixup patch attached removing
> those print statements).  I have it running on a 4 way opteron box running
> prio-preempt in a timed while loop, exiting only on failure.  It's been
> running fine for several minutes - usually fails in under a mintue.  We'll
> see how it's doing in the morning :-)

Well it failed in about 14 minutes.  The machine was under heavy load running 
another benchmark.  I have removed the secondary benchmark and am running 
prio-preempt alone on the same 4 way opteron box.  Will post again when I 
know more...

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
