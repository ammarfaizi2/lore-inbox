Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315838AbSEJIZu>; Fri, 10 May 2002 04:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315839AbSEJIZt>; Fri, 10 May 2002 04:25:49 -0400
Received: from imladris.infradead.org ([194.205.184.45]:9231 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315838AbSEJIZt>; Fri, 10 May 2002 04:25:49 -0400
Date: Fri, 10 May 2002 09:24:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8
Message-ID: <20020510092436.A7038@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patricia Gaughen <gone@us.ibm.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <hch@infradead.org> <200205100130.g4A1U2615224@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 06:30:01PM -0700, Patricia Gaughen wrote:
> Okay here's the updated version of the patch. 
> 
> you can get it off of sourceforge at:
> 
> http://west.dl.sourceforge.net/sourceforge/lse/x86_discontigmem-2.4.19pre8-2
> 
> This patch depends on the  the modularization of setup_arch() patch I sent out 
> yesterday, and also on the version of the modularization of mem_init() patch 
> that Christoph posted (which I copied onto sourceforge:  it's 
> x86_meminit-2.4.19pre8-3).

This looks much better.  The only question that came up to me now that
the CONFIG_ stuff is cleaned up a lot: What is the difference between
CONFIG_X86_NUMAQ and CONFIG_MULTIQUAD?

