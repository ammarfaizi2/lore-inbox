Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313904AbSEDPCl>; Sat, 4 May 2002 11:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313988AbSEDPCk>; Sat, 4 May 2002 11:02:40 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14343 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313904AbSEDPCk>; Sat, 4 May 2002 11:02:40 -0400
Date: Sat, 4 May 2002 16:02:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.4.19pre8aa2
Message-ID: <20020504160235.A14926@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>
In-Reply-To: <20020504165440.C1260@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 04:54:40PM +0200, Andrea Arcangeli wrote:
> Only in 2.4.19pre8aa2: 00_comx-driver-compile-1
> 
> 	Export proc_get_inode for kernel/drivers/net/wan/comx.o so
> 	it can link as a module, noticed by Eyal Lebedinsky.

Don't do this - proc_get_inode is static for a reason and doing this
export in the SuSE tree for ages doesn't make it any better.

The driver needs serious fixing instead.

