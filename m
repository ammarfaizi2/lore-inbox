Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVDCPZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVDCPZh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 11:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbVDCPZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 11:25:37 -0400
Received: from [213.170.72.194] ([213.170.72.194]:22247 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261808AbVDCPYc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 11:24:32 -0400
Message-ID: <42500AAC.5080105@yandex.ru>
Date: Sun, 03 Apr 2005 19:24:28 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>,
       "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au> <424FB06B.3060607@yandex.ru> <20050403093044.GA20608@gondor.apana.org.au> <424FBB56.5090503@yandex.ru> <20050403100043.GA20768@gondor.apana.org.au> <1112522762.3899.182.camel@localhost.localdomain> <20050403101752.GA20866@gondor.apana.org.au> <424FC42E.80503@yandex.ru> <20050403114207.GB21255@gondor.apana.org.au>
In-Reply-To: <20050403114207.GB21255@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> This relies on implementation details within zlib_deflate, which may
> or may not be the case.
> 
> It should be easy to test though.  Just write a user-space program
> which does exactly this and feed it something from /dev/urandom.
> 
Well, Herbert, you're right. In case of non-compressible data things
are bad. I'll continue investigating this.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
