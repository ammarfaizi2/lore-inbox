Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUJFEQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUJFEQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 00:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUJFEQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 00:16:49 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:4294 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267164AbUJFEQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 00:16:47 -0400
Subject: Re: Preempt? (was Re: Cannot enable DMA on SATA drive
	(SCSI-libsata, VIA SATA))
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@novell.com>,
       Roland Dreier <roland@topspin.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41636FCF.3060600@pobox.com>
References: <52is9or78f.fsf_-_@topspin.com> <4163465F.6070309@pobox.com>
	 <41634A34.20500@yahoo.com.au> <41634CF3.5040807@pobox.com>
	 <1097027575.5062.100.camel@localhost>
	 <20041006015515.GA28536@havoc.gtf.org> <41635248.5090903@yahoo.com.au>
	 <20041006020734.GA29383@havoc.gtf.org>
	 <20041006031726.GK26820@dualathlon.random> <4163660A.4010804@pobox.com>
	 <20041006040323.GL26820@dualathlon.random>  <41636FCF.3060600@pobox.com>
Content-Type: text/plain
Message-Id: <1097036205.1359.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 00:16:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 00:08, Jeff Garzik wrote:
> Preempt will always be something I ask people to turn off when reporting 
> driver bugs; it just adds too much complicated mess for zero gain.

I agree that many people are using preempt who should not be.  Currently
the Kconfig help recommends enabling preempt for a "desktop or embedded
system".  Maybe we should lose the desktop part.  99% of users do not
need the low latencies that require preempt, and those users know who
they are.

Lee

