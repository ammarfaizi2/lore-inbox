Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTFFITX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTFFITX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 04:19:23 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:61458 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264894AbTFFITW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 04:19:22 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: kingsley@aurema.com (Kingsley Cheung), linux-kernel@vger.kernel.org
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30 seconds)
In-Reply-To: <20030606122653.B29095@aurema.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-1-686-smp (i686))
Message-Id: <E19OCdo-0006HB-00@gondolin.me.apana.org.au>
Date: Fri, 06 Jun 2003 18:32:04 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kingsley Cheung <kingsley@aurema.com> wrote:
> 
> Attached is a trivial patch to fix the problem against 2.5.70.  I've
> also attached the trivial 2.4.20 patch I sent to Rusty back for
> completeness.

What happens when the system time is changed later on?
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
