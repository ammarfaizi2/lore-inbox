Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264325AbUEMWXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbUEMWXZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265190AbUEMWXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:23:25 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14859 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264325AbUEMWXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:23:24 -0400
Subject: Re: [PATCH] AES i586 optimized
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Fruhwirth Clemens <clemens-dated-1085310070.4b1f@endorphin.org>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040513110110.GA8491@ghanima.endorphin.org>
References: <20040513110110.GA8491@ghanima.endorphin.org>
Content-Type: text/plain
Message-Id: <1084487008.1688.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 14 May 2004 00:23:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 13:01, Fruhwirth Clemens wrote:
> Hi,
> 
> The following patch adds an i586 optimized implementation of AES aka
> Rijndael. It's following an integration strategy similiar to recent
> s390/z990 integration for DES/SHA1. aes-i586-glue.c, a glue layer for
> CryptoAPI, and aes-i586-asm.S, the actual implementation, are added to
> arch/i386/crypto, as well as a config section to crypto/Kconfig.
> 
> The code has been in use for half a year by myself and the loop-aes project
> for the last - I think - 2 years. I consider the implementation
> production-stable. Andrew, please consider applying.
> 
> Best Regards, Clemens

Could you please update your patch to work when CONFIG_REGPARMS is
enabled? I find this i586-optimized AES patch very useful to me as I use
AES-encrypted IPSec extensively.

Thanks.

