Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbTABHNb>; Thu, 2 Jan 2003 02:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTABHNb>; Thu, 2 Jan 2003 02:13:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:3776 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266218AbTABHNa>;
	Thu, 2 Jan 2003 02:13:30 -0500
Message-ID: <3E13E890.5E087169@digeo.com>
Date: Wed, 01 Jan 2003 23:21:52 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sowmya Adiga <sowmya.adiga@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53mm3
References: <008001c2b22e$e5d35fb0$6009720a@wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 07:21:53.0244 (UTC) FILETIME=[9FB4F9C0:01C2B22F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sowmya Adiga wrote:
> 
> 2.5.53mm3 patch faces problem while booting
> 
> double fault:0000
> CPU:0
> EIP:0060:[<c0123dd4 ] Not tainted
> EFLAGS:00010003
> 
> and the same things repeats.cannot able to exactly pick up where the
> problem is,
> as screen moves very fast.
> 

Please test 2.5.54-mm1.  Hook up a serial console (Documentation/serial-console.txt)
and enable CONFIG_KALLSYMS.
