Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267979AbUHKHwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267979AbUHKHwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267983AbUHKHwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:52:23 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44229 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267979AbUHKHwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:52:22 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O5
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040811074256.GA5298@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <1092174959.5061.6.camel@mindpipe>
	 <20040811073149.GA4312@elte.hu>  <20040811074256.GA5298@elte.hu>
Content-Type: text/plain
Message-Id: <1092210765.1650.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 03:52:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 03:42, Ingo Molnar wrote:

> (another thing: could you turn on CONFIG_DEBUG_HIGHMEM,
> CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP? Lets make sure
> that what we are seeing here is not somehow caused by atomicity
> violations.)

I have highmem disabled per your previous request.  Should I turn it
back on?

Lee

