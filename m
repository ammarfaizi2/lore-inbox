Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbUJaLy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbUJaLy4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUJaLxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:53:07 -0500
Received: from c211-30-229-77.rivrw4.nsw.optusnet.com.au ([211.30.229.77]:40461
	"EHLO arnor.apana.org.au") by vger.kernel.org with ESMTP
	id S261550AbUJaLwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 06:52:41 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton)
Subject: Re: [PATCH 475] HP300 LANCE
Cc: jgarzik@pobox.com, geert@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Organization: Core
In-Reply-To: <20041031030931.3d592bf2.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel,apana.lists.os.linux.net
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1COEEO-0002lX-00@gondolin.me.apana.org.au>
Date: Sun, 31 Oct 2004 22:50:44 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>> On Sun, Oct 31, 2004 at 02:48:40AM -0800, Andrew Morton wrote:
>>  > > -        void *va = dio_scodetoviraddr(scode);
>>  > > +        unsigned long pa = dio_scodetophysaddr(scode);
>>  > > +        unsigned long va = (pa + DIO_VIRADDRBASE);
>> 
>>  Did you see the above quoted patch chunk?  The patch is inconsistent
>>  with _itself_, adding 'pa' and 'va' with different idents (but when they
>>  should be at the same identation level).
> 
> Trust me ;)

What Jeff means is that the patch is using a tab for pa and 8 spaces
for va.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
