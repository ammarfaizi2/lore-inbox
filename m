Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264026AbRFMQOr>; Wed, 13 Jun 2001 12:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264029AbRFMQOh>; Wed, 13 Jun 2001 12:14:37 -0400
Received: from c017-h015.c017.sfo.cp.net ([209.228.12.229]:13041 "HELO
	c017.sfo.cp.net") by vger.kernel.org with SMTP id <S264026AbRFMQOQ>;
	Wed, 13 Jun 2001 12:14:16 -0400
X-Sent: 13 Jun 2001 16:14:14 GMT
Message-ID: <3B277C2A.B2CC3FCF@sangate.com>
Date: Wed, 13 Jun 2001 17:43:54 +0300
From: Mark Mokryn <mark@sangate.com>
Organization: SANgate Systems
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rafael Herrera <raffo@neuronet.pitt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP module compilation on UP?
In-Reply-To: <3B276DDE.A19F60DF@sangate.com> <3B278602.B1C4DFB8@neuronet.pitt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael Herrera wrote:
> 
> Mark Mokryn wrote:
> > Is it possible to build an SMP module on a machine running a UP kernel
> > (or vice versa)? We of course get unresolved symbols during module load
> > due to the smp prefix on the ksyms, and haven't seen how to get around
> > it. (Defining __SMP__ does not cut it, though I believe this used to
> > work a while ago).
> 
> Yes. It does not matter what kernel you are running. What's important is
> that you configure your sources. Configure your kernel for SMP and do a
> 'make dep', then compile your module.
> --
>      Rafael

Is this the only way - to keep two separately configured kernel source
trees? No way to do it via some flag?

thanks,
-mark
