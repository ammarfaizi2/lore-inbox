Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUJFEFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUJFEFz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUJFEFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:05:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45252 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266879AbUJFEFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:05:01 -0400
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
	(SCSI-libsata, VIA SATA))
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrea Arcangeli <andrea@novell.com>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41636D8B.8020401@pobox.com>
References: <4136E4660006E2F7@mail-7.tiscali.it>
	 <41634236.1020602@pobox.com> <52is9or78f.fsf_-_@topspin.com>
	 <4163465F.6070309@pobox.com> <41634A34.20500@yahoo.com.au>
	 <41634CF3.5040807@pobox.com> <1097027575.5062.100.camel@localhost>
	 <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au>
	 <20041006020734.GA29383@havoc.gtf.org>
	 <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com>
	 <416369F9.7050205@yahoo.com.au>  <41636D8B.8020401@pobox.com>
Content-Type: text/plain
Message-Id: <1097035500.1359.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 00:05:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 23:59, Jeff Garzik wrote:
> The moral of the story is not to use preempt, as it
> * potentially hides long latency code paths
> * potentially introduces bugs, as we've seen with net stack and many 
> other pieces of code
> * is simply not needed, if all code paths are fixed

That's a pretty big if.  If you require low latency now as opposed to
Real Soon Now then preempt is the only option.

Lee

