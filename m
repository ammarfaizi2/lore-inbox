Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWEIN0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWEIN0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbWEIN0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:26:13 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:39954 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932510AbWEIN0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:26:12 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christian.Limpach@cl.cam.ac.uk (Christian Limpach)
Subject: Re: [Xen-devel] [RFC PATCH 34/35] Add the Xen virtual network	device	driver.
Cc: herbert@gondor.apana.org.au, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       virtualization@lists.osdl.org
Organization: Core
In-Reply-To: <20060509131632.GB7834@cl.cam.ac.uk>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.netdev,apana.lists.os.xen.devel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1FdSDz-0008Lv-00@gondolin.me.apana.org.au>
Date: Tue, 09 May 2006 23:26:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Limpach <Christian.Limpach@cl.cam.ac.uk> wrote:
> 
> Possibly having to page in the process and switching to it would add
> to the live migration time.  More importantly, having to install an
> additional program in the guest is certainly not very convenient.

Sorry I'm still not convinced.  What's there to stop me from suspending
my laptop to disk, moving it from port A to port B and resuming it?

Wouldn't I be in exactly the same situation? By the same reasoning we'd
be adding a gratuitous ARP routine to every single laptop network driver.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
