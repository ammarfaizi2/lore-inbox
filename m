Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbVDCJAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbVDCJAA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 05:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVDCI7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:59:31 -0400
Received: from [213.170.72.194] ([213.170.72.194]:36557 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261621AbVDCI7Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:59:24 -0400
Message-ID: <424FB06B.3060607@yandex.ru>
Date: Sun, 03 Apr 2005 12:59:23 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>, dwmw2@infradead.org,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <20050401152325.GB4150@gondor.apana.org.au> <Pine.LNX.4.58.0504011640340.9305@phoenix.infradead.org> <20050401221303.GA6557@gondor.apana.org.au> <424FA7B4.6050008@yandex.ru> <20050403084415.GA20326@gondor.apana.org.au>
In-Reply-To: <20050403084415.GA20326@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Surely that defeats the purpose of pcompress? I thought the whole point
> was to compress as much of the input as possible into the output?
Absolutely correct.

> So 1G into 1G doesn't make sense here.
I thought you are afraid about the case of a totally random input which 
may *grow* after it has been compressed.

> But 1G into 1M does and you
> want to put as much as you can in there.  Otherwise we might as well
> delete crypto_comp_pcompress :)

Err, it looks like we've lost the conversation flow. :-) I commented 
your phrase: "The question is what happens when you compress 1 1GiB 
input buffer into a 1GiB output buffer."

Then could you please in a nutshell write what worries you or what issue 
you would like to clarify?

IIRC, you worried that in case of a large input and output 12 bytes 
won't be enough. I argued it should. I'm even going to check this soon :-)

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
