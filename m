Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDCIsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDCIsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 04:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVDCIsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:48:12 -0400
Received: from [213.170.72.194] ([213.170.72.194]:49612 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261608AbVDCIr7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:47:59 -0400
Message-ID: <424FADBC.208@yandex.ru>
Date: Sun, 03 Apr 2005 12:47:56 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       linux-crypto@vger.kernel.org
Subject: Re: [RFC] CryptoAPI & Compression
References: <E1DGxa7-0000GH-00@gondolin.me.apana.org.au> <Pine.LNX.4.58.0504011534460.9305@phoenix.infradead.org> <1112366647.3899.66.camel@localhost.localdomain> <424D6175.8000700@yandex.ru> <1112367926.3899.70.camel@localhost.localdomain> <Pine.LNX.4.58.0504011622350.9305@phoenix.infradead.org> <20050401153347.GA16835@wohnheim.fh-wedel.de>
In-Reply-To: <20050401153347.GA16835@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jörn Engel wrote:
 > Absolutely.  You can argue that 4KiB is too small and 8|16|32|64|...
 > would be much better, yielding in better compression ratio.  But
 > having to read and uncompress the whole file when appending a few
 > bytes is utter madness.
 >
Dear Joern,

I meant that JFFS2 always reads by portions of PAGE_SIZE bytes due to 
the Page Cache. Consequently, nodes cotaining the peaces of the same 
page don't have to be independently uncompressible. Yes, there are some 
difficulties. But this is off-topic anyway and I don't think it is worth 
to discuss this here :-)

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

