Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSHVTpL>; Thu, 22 Aug 2002 15:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316623AbSHVTpL>; Thu, 22 Aug 2002 15:45:11 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:49643 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S316614AbSHVTpK>; Thu, 22 Aug 2002 15:45:10 -0400
Subject: Re: MM patches against 2.5.31
From: Steven Cole <elenstev@mesatop.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
In-Reply-To: <2631076918.1030007179@[10.10.2.3]>
References: <1030031958.14756.479.camel@spc9.esa.lanl.gov> 
	<2631076918.1030007179@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 22 Aug 2002 13:45:52 -0600
Message-Id: <1030045552.3954.10.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-08-22 at 10:06, Martin J. Bligh wrote:
> > kjournald: page allocation failure. order:0, mode:0x0
> 
> I've seen this before, but am curious how we ever passed
> a gfpmask (aka mode) of 0 to __alloc_pages? Can't see anywhere
> that does this?
> 
> Thanks,
> 
> M.

I ran dbench 1..128 on 2.5.31-mm1 several more times with nothing
unusual happening, and then got this from pdflush with dbench 96.

pdflush: page allocation failure. order:0, mode:0x0

FWIW, this 2.5.31-mm1 kernel is SMP, HIGHMEM4G, no PREEMPT.

Steven

