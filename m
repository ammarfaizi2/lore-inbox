Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVCHFI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVCHFI6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbVCHFI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:08:57 -0500
Received: from smtpout.mac.com ([17.250.248.44]:62152 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261835AbVCHFIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:08:53 -0500
In-Reply-To: <11102278521318@2ka.mipt.ru>
References: <11102278521318@2ka.mipt.ru>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1FA9E37C-8F90-11D9-A2CF-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       cryptoapi@lists.logix.cz, David Miller <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@osdl.org>,
       Fruhwirth Clemens <clemens@endorphin.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [0/many] Acrypto - asynchronous crypto layer for linux kernel 2.6
Date: Tue, 8 Mar 2005 00:08:35 -0500
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 07, 2005, at 15:37, Evgeniy Polyakov wrote:
> I'm pleased to announce asynchronous crypto layer for Linux kernel 2.6.
> It supports following features:
> - multiple asynchronous crypto device queues
> - crypto session routing
> - crypto session binding
> - modular load balancing
> - crypto session batching genetically implemented by design
> - crypto session priority
> - different kinds of crypto operation(RNG, asymmetrical crypto, HMAC 
> and
> any other)

Did you include support for the new key/keyring infrastructure 
introduced
a couple versions ago by David Howells?  It allows userspace to create 
and
manage various sorts of "keys" in kernelspace.  If you create and 
register
a few keytypes for various symmetric and asymmetric ciphers, you could 
then
take advantage of its support for securely passing keys around in and 
out
of userspace.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


