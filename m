Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbVDDDLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVDDDLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 23:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDDDLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 23:11:30 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:40459 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261721AbVDDDL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 23:11:27 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: da@osvik.no (Dag Arne Osvik)
Subject: Re: Use of C99 int types
Cc: viro@parcelfarce.linux.theplanet.co.uk, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <42507645.6010808@osvik.no>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DIHww-0004bU-00@gondolin.me.apana.org.au>
Date: Mon, 04 Apr 2005 13:08:26 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dag Arne Osvik <da@osvik.no> wrote:
>
>>... and with such name 99% will assume (at least at the first reading)
>>that it _is_ 32bits.  We have more than enough portability bugs as it
>>is, no need to invite more by bad names.
> 
> Agreed.  The way I see it there are two reasonable options.  One is to 
> just use u32, which is always correct but sacrifices speed (at least 
> with the current gcc).  The other is to introduce C99 types, which Linus 
> doesn't seem to object to when they are kept away from interfaces 
> (http://infocenter.guardiandigital.com/archive/linux-kernel/2004/Dec/0117.html).

There is a third option which has already been pointed out before:

Use unsigned long.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
