Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSEASDl>; Wed, 1 May 2002 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313773AbSEASDk>; Wed, 1 May 2002 14:03:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54150 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313767AbSEASDj>; Wed, 1 May 2002 14:03:39 -0400
Message-Id: <200205011800.g41I0G002507@w-gaughen.des.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Christoph Hellwig <hch@infradead.org>,
        William Lee Irwin III <wli@holomorphy.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7 
In-Reply-To: Message from Christoph Hellwig <hch@infradead.org> 
   of "Wed, 01 May 2002 10:23:28 BST." <20020501102328.B1238@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 01 May 2002 11:00:16 -0700
From: Patricia Gaughen <gone@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  > On Tue, Apr 30, 2002 at 06:22:13PM -0700, William Lee Irwin III wrote:
  > > > Umm, NUMA without SMP looks rather strange to me..
  > > 
  > > It's still fully possible, though I'm not clear on whether NUMA-Q
  > > supports it.
  > 
  > It doesn't really make sense :)
  > 
  > Still I think it makes sense to have CONFIG_NUMAQ or whatever to depend
  > on CONFIG_SMP

The way it is currently defined in the patch is that CONFIG_IBMNUMAQ (which 
turns on CONFIG_DISCONTIGMEM) depends on CONFIG_MULTIQUAD being set and that 
depends on CONFIG_SMP being set.  So, I'm still planning on removing the 
#ifdef SMP.  :-)

-Pat



