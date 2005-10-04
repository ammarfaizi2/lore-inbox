Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVJDQ3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVJDQ3r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVJDQ3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:29:47 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:65295 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932239AbVJDQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:29:47 -0400
Date: Tue, 4 Oct 2005 18:29:38 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Felix Oxley <lkml@oxley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make xconfig fails for older kernels
Message-ID: <20051004162938.GL3652@stusta.de>
References: <4TJDn-2mm-3@gated-at.bofh.it> <4341FBA8.3020208@shaw.ca> <200510041034.07837.lkml@oxley.org> <43428BD3.9090407@oxley.org> <43428DCC.7030808@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43428DCC.7030808@oxley.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2005 at 03:12:28PM +0100, Felix Oxley wrote:
> 
> >Felix Oxley wrote:
> >
> >>I think you have nailed it.  I'm using GCC 4.0.2. Incidentally the 
> >>first 2.6 kernel in which this issue was resolved is 2.6.9.
> >
> >
> >For the record, the first version of the stock kernel which will build 
> >for me with GCC 4.0.2 is 2.16.12. (Using a minimal .config)
> >
> 
> To clarify, using GCC 4.0.2 I get the following:
> 
> 	<= 2.6.9 	cannot make config/menuconfig/xconfig
> 	2.6.10 + 11	build fails in i386/asm(?)
> 	2.6.12		builds ok

Assuming you are on i386 this 100% what was expected since kernel 2.6.12 
is the first kernel to compile with gcc 4.0 .

> Felix

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

