Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261323AbTILLMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 07:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTILLMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 07:12:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50388 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261323AbTILLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 07:12:02 -0400
Date: Fri, 12 Sep 2003 13:11:57 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] fix nfs4xdr.c compile warning
Message-ID: <20030912111157.GG27368@fs.tum.de>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <20030909113831.GN14800@fs.tum.de> <16225.12839.319206.649577@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16225.12839.319206.649577@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 12:40:39PM +1000, Neil Brown wrote:
>...
> > BTW:
> > Shouldn't the return values of nfsd4_encode_open{,_confirm,_downgrade} 
> > be checked in the switch in nfsd4_encode_operation?
> 
> No.  There is nothing meaningful in their return values.

They return nfserr from ENCODE_SEQID_OP_TAIL.

If this isn't meaningful, should I send a patch that removes this return 
from ENCODE_SEQID_OP_TAIL and changes these three functions to return 
void?

> NeilBrown

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

