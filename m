Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVC3VwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVC3VwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:49:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29123 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262326AbVC3VtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:49:25 -0500
Message-ID: <424B1ED0.3010705@pobox.com>
Date: Wed, 30 Mar 2005 16:49:04 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
   (2.6.11)
References: <4249D06F.30802@tmr.com><4249D06F.30802@tmr.com> <4249DAD4.9020602@pobox.com> <424B18A1.2060502@tmr.com>
In-Reply-To: <424B18A1.2060502@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> If the hardware RNG always fails to all zeros it should be possible to 
> detect that it failed with the need for userspace daemons.  While true 
> random bits might legitimately have 10k zeros in a row, I will bet that 
> if it happens the device isn't working.


Or all 1's (more likely), or all 0x55's, or...

	Jeff


