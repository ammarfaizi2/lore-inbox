Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271016AbSISKdh>; Thu, 19 Sep 2002 06:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271072AbSISKdg>; Thu, 19 Sep 2002 06:33:36 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:26611
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271016AbSISKdg>; Thu, 19 Sep 2002 06:33:36 -0400
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
In-Reply-To: <3D8944EC.D129579D@digeo.com>
References: <20020918.160057.17194839.davem@redhat.com>
	<1032393277.24895.8.camel@irongate.swansea.linux.org.uk>
	<3D89176B.40FFD09B@digeo.com> <20020919021333.GC20500@vitelus.com> 
	<3D8944EC.D129579D@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 11:42:43 +0100
Message-Id: <1032432163.26669.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 04:30, Andrew Morton wrote:
> > It's disappointing that this program doesn't seem to support
> > benchmarking of MMX copy loops (like the ones in arch/i386/lib/mmx.c).
> > Those seem to be the more interesting memcpy functions on modern
> > systems.
> 
> Well the source is there, and the licensing terms are most reasonable.
> 
> But then, the source was there eighteen months ago and nothing happened.
> Sigh.
> 
> I think in-kernel MMX has fatal drawbacks anyway.  Not sure what
> they are - I prefer to pretend that x86 CPUs execute raw C.

MMX isnt useful for anything smaller than about 512bytes-1K. Its not
useful in interrupt handlers. The list goes on.

