Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311425AbSCSQdh>; Tue, 19 Mar 2002 11:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSCSQd1>; Tue, 19 Mar 2002 11:33:27 -0500
Received: from pc3-camc5-0-cust13.cam.cable.ntl.com ([80.4.125.13]:18830 "EHLO
	fenrus.demon.nl") by vger.kernel.org with ESMTP id <S311422AbSCSQdO>;
	Tue, 19 Mar 2002 11:33:14 -0500
Date: Tue, 19 Mar 2002 16:30:41 +0000
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tigran Aivazian <Tigran.Aivazian@veritas.com>, kraxel@bytesex.org,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [patch] vmalloc_to_page() backport for 2.4
Message-ID: <20020319163041.B17735@fenrus.demon.nl>
In-Reply-To: <E16lVkh-0000oW-00@the-village.bc.nu> <Pine.LNX.4.21.0203141436150.1153-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 02:46:39PM +0000, Hugh Dickins wrote:
> On Thu, 14 Mar 2002, Alan Cox wrote:
> > 
> > Similarly the PAE/non-PAE thing is a red herring. Given that even basic
> > data types change size on pae no module is going to be magically pae/non-pae
> > clean if its binary only.
> 
> Few modules take an interest in ptes, that's as it should be, and so
> few modules build to different binaries with CONFIX_X86_PAE off or on
> (modulo module versions).

Well dma_addr_t and some others also change size..... struct page also
changes quite a bit
