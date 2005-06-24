Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbVFXHi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbVFXHi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 03:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbVFXHi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 03:38:57 -0400
Received: from [213.170.72.194] ([213.170.72.194]:33740 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S263204AbVFXHgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 03:36:31 -0400
Message-ID: <42BBB7F8.8070309@yandex.ru>
Date: Fri, 24 Jun 2005 11:36:24 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: "Kluba, Patrik" <pajko@halom.u-szeged.hu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Ferenc Havasi <havasi@inf.u-szeged.hu>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Michal Ludvig <michal@logix.cz>
Subject: Re: cryptoapi compression modules & JFFSx
References: <1119555217l.7540l.1l@detonator>
In-Reply-To: <1119555217l.7540l.1l@detonator>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kluba, Patrik wrote:
> 
> Hi everybody,
> 
> I'm going to port JFFS2's compression modules to CryptoApi except  
> {in|de}flate, which Artem is working(?) on.
No, I don't work on that anymore, so you probably want to port deflate 
as well. My investigation showed that it can't be easily done without 
hacking zlib internals, unless you greatly lose the compression ratio by 
flushing the zstream and do other ugly things.

Nevertheless, you're the compression specialist(s), so you should do 
this better :-)


-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
