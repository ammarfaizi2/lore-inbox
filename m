Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVDQU1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDQU1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbVDQUY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:24:29 -0400
Received: from hermes.domdv.de ([193.102.202.1]:9234 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261507AbVDQUYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:24:06 -0400
Message-ID: <4262C5E0.5070106@domdv.de>
Date: Sun, 17 Apr 2005 22:24:00 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de,
       linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: [RFC][PATCH 4/4] AES assembler implementation for x86_64
References: <4262B6F5.4060907@domdv.de> <20050417195406.GC3625@stusta.de>
In-Reply-To: <20050417195406.GC3625@stusta.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> That is not specifically against this patch, but before we add another 
> AES implementation, I'd like to find a better solution for the general 
> AES selection.

That would be nice as I didn't like having to duplicate a whole Kconfig
entry which in fact means that it is triplicated now.
I'm fine with any solution here but I do believe whatever solution is
for the crypto maintainers to decide.

[snip]

>>+	depends on CRYPTO && (X86 && !X86_64)
>>+	depends on CRYPTO && X86 && !X86_64
>>...
> 
> 
> This doesn't make any difference.
> 
> I think the former version was better readable, but that's no strong 
> opinion.

This was only personal preference during development and actually you're
right, the former version is better readable.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
