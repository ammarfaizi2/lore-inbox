Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSFFWrC>; Thu, 6 Jun 2002 18:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSFFWrC>; Thu, 6 Jun 2002 18:47:02 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:5360 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S290289AbSFFWrB>; Thu, 6 Jun 2002 18:47:01 -0400
Date: Thu, 6 Jun 2002 18:47:02 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: ET Sales <sales@etinc.com>
Cc: nick@snowman.net, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Loosing packets with Dlink DFE-580TX and SMC 9462TX
Message-ID: <20020606184702.E12341@redhat.com>
In-Reply-To: <vewutgw4n1.fsf@inigo.ingate.se> <Pine.LNX.4.21.0206031956150.8643-100000@ns> <5.1.0.14.0.20020606091713.021f0730@mail.etinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 09:21:50AM -0400, ET Sales wrote:
> At 07:56 PM 6/3/02 -0400, you wrote:
> 
> Uh..aren't those 32-bit cards? There isn't enough bus bandwidth on a 32bit 
> PCI bus to do gigabit, so its more likely that the cards are overrunning 
> their buffers....

32 bit cards are okay for most applications that don't use all bandwidth 
in both directions.  Also, if overruns occur, recent versions of ns83820.c 
do update the error counts in /proc/net/dev.

		-ben
