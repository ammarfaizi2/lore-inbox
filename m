Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUCCJmI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 04:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUCCJmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 04:42:08 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:24330 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261982AbUCCJlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 04:41:53 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmorris@redhat.com (James Morris), linux-kernel@vger.kernel.org
Subject: Re: Mysterious string truncation in 2.4.25 kernel
Organization: Core
In-Reply-To: <Xine.LNX.4.44.0403030043380.32045-100000@thoron.boston.redhat.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20031226 ("Taransay") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1AySsn-0006zH-00@gondolin.me.apana.org.au>
Date: Wed, 03 Mar 2004 20:41:41 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
> On Tue, 2 Mar 2004, Glen Nakamura wrote:
> 
>> Of course, perhaps 0 should passed instead of "" for data_page?
>> 
>> -    err = do_mount ("none", "/dev", "devfs", 0, "");
>> +    err = do_mount ("none", "/dev", "devfs", 0, 0);
>>
>> Comments?
> 
> Yes, the devfs fix above is needed if the data_page patch has been 
> applied.  
> 
> This is the case in 2.6, but not 2.4.25.

Hmm the data_page line is in my copy of 2.4.25...
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
