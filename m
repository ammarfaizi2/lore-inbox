Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVIAMfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVIAMfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 08:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIAMfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 08:35:01 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:26845 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S965091AbVIAMfA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 08:35:00 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: ndbecker2@gmail.com (Neal Becker)
Subject: Re: via hardware accelerated crypto support
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <df6nb3$k3g$1@sea.gmane.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EAoHH-0003UD-00@gondolin.me.apana.org.au>
Date: Thu, 01 Sep 2005 22:34:47 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal Becker <ndbecker2@gmail.com> wrote:
> I haven't been following linux kernel development for a while, so I'm not
> sure what the status is.  I noticed that there is now crypto support in the
> kernel, including e.g. AES.  I would like to use hardware acceleration
> where available, e.g., VIA EPIA.  Does the current kernel crypto support
> include hardware acceleration, or is there any projects working on this?

Yes recent 2.6 kernels fully support the VIA Padlock device for AES
encryption.  All you need to do is load the padlock module or have
it built into your kernel.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
