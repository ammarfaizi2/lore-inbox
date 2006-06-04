Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751049AbWFDULG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWFDULG (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWFDULG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:5608 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750764AbWFDULF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:11:05 -0400
From: Andi Kleen <ak@suse.de>
To: Joachim Fritschi <jfritschi@freenet.de>
Subject: Re: [PATCH  4/4] Twofish cipher - x86_64 assembler
Date: Sun, 4 Jun 2006 21:10:14 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <200606041516.46920.jfritschi@freenet.de>
In-Reply-To: <200606041516.46920.jfritschi@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606042110.15060.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 June 2006 15:16, Joachim Fritschi wrote:
> This patch adds the twofish x86_64 assembler routine.
>
> Changes since last version:
> - The keysetup is now handled by the twofish_common.c (see patch 1 )
> - The last round of the encrypt/decrypt routines where optimized saving 5
> instructions.
>
> Correctness was verified with the tcrypt module and automated test scripts.

Do you have some benchmark numbers that show that it's actually worth
it?

> +/* Defining a few register aliases for better reading */

Maybe you can read it now better, but for everybody else it is extremly 
confusing. It would be better if you just used the original register names.

-andi
