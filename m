Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVBQONM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVBQONM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVBQONL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:13:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10770 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262151AbVBQOMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:12:50 -0500
Date: Thu, 17 Feb 2005 15:12:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@cse.unsw.edu.au>, Olaf Kirch <okir@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 7/13] Encode and decode arbitrary XDR arrays
Message-ID: <20050217141244.GF24808@stusta.de>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203619.570180000@blunzn.suse.de> <1108495038.10073.102.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108495038.10073.102.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 02:17:18PM -0500, Trond Myklebust wrote:
> 
> net/sunrpc/xdr.c:1024:3: warning: mixing declarations and code
>...
> Please don't use these gcc extensions in the kernel.

Just for the record:
This is not a gcc extension - this is C99 but not supported by
gcc 2.95 (which is a supported compiler for kernel 2.6).

> Cheers,
>   Trond

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

