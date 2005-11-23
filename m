Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVKWQZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVKWQZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVKWQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:25:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48397 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751208AbVKWQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:25:40 -0500
Date: Wed, 23 Nov 2005 17:25:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: David Miller <davem@davemloft.net>, neilb@cse.unsw.edu.au,
       trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, netdev@vger.kernel.org
Subject: Re: [2.6 patch] net/sunrpc/xdr.c: remove xdr_decode_string()
Message-ID: <20051123162528.GL3963@stusta.de>
References: <044B81DE141D7443BCE91E8F44B3C1E2013327DF@exsvl02.hq.netapp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044B81DE141D7443BCE91E8F44B3C1E2013327DF@exsvl02.hq.netapp.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 04:31:14AM -0800, Lever, Charles wrote:
> > On Thu, Oct 06, 2005 at 07:13:14AM -0700, Lever, Charles wrote:
> > 
> > > actually, can we hold off on this change?  the RPC 
> > transport switch will
> > > eventually need most of those EXPORT_SYMBOLs.
> > 
> > Am I right to assume this will happen in the foreseeable future?
> 
> the first portion of the transport switch is in 2.6.15-rcX.  at this
> point i'm expecting the EXPORT_SYMBOL changes to go in 2.6.17 or later.

OK.

> so i don't remember why you are removing xdr_decode_string.  are we sure
> that no-one will need this functionality in the future?  it is harmless
> to remove today, but i wonder if someone is just going to add it back
> sometime.

It's unused and you said:
  the only harmless change i see below is removing xdr_decode_string().

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

