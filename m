Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbRFMP0Y>; Wed, 13 Jun 2001 11:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264005AbRFMP0O>; Wed, 13 Jun 2001 11:26:14 -0400
Received: from smtp6vepub.gte.net ([206.46.170.27]:378 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S264001AbRFMP0D>; Wed, 13 Jun 2001 11:26:03 -0400
Message-ID: <3B278602.B1C4DFB8@neuronet.pitt.edu>
Date: Wed, 13 Jun 2001 11:25:54 -0400
From: Rafael Herrera <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4.SuSE-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Mokryn <mark@sangate.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP module compilation on UP?
In-Reply-To: <3B276DDE.A19F60DF@sangate.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mokryn wrote:
> Is it possible to build an SMP module on a machine running a UP kernel
> (or vice versa)? We of course get unresolved symbols during module load
> due to the smp prefix on the ksyms, and haven't seen how to get around
> it. (Defining __SMP__ does not cut it, though I believe this used to
> work a while ago).

Yes. It does not matter what kernel you are running. What's important is
that you configure your sources. Configure your kernel for SMP and do a
'make dep', then compile your module.
-- 
     Rafael
