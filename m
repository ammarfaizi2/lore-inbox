Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVC3K2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVC3K2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVC3K2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:28:50 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:45064 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261855AbVC3K2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:28:48 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: pj@engr.sgi.com (Paul Jackson)
Subject: Re: [patch 1/2] fork_connector: add a fork connector
Cc: guillaume.thouvenin@bull.net, johnpol@2ka.mipt.ru, akpm@osdl.org,
       greg@kroah.com, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       efocht@hpce.nec.com, linuxram@us.ibm.com, gh@us.ibm.com,
       elsa-devel@lists.sourceforge.net
Organization: Core
In-Reply-To: <20050329223534.62f78b0a.pj@engr.sgi.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DGaOG-0002Md-00@gondolin.me.apana.org.au>
Date: Wed, 30 Mar 2005 20:25:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@engr.sgi.com> wrote:
> 
> So I suppose if fork_connector were not used to collect <parent pid,
> child pid> information for accounting, then someone would have to make
> the case that there were enough other uses, of sufficient value, to add
> fork_connector.  We have to be a bit careful, in the kernel, to avoid
> adding mechanisms until we have the immediate use in hand.  If we don't
> do this, then the kernel ends up looking like the Gargoyles on a
> Renaissance church - burdened with overly ornate features serving no
> earthly purpose.

I agree completely.  In fact the whole drivers/connector directory
looks pretty suspect.  Are there any in-kernel users of it at all?
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
