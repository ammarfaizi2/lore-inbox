Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264513AbUEOFx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbUEOFx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 01:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbUEOFx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 01:53:58 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:25618 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264513AbUEOFx5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 01:53:57 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: akpm@osdl.org (Andrew Morton), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
Organization: Core
In-Reply-To: <20040514175918.6b9f4c9d.akpm@osdl.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BOs7C-0003Bd-00@gondolin.me.apana.org.au>
Date: Sat, 15 May 2004 15:53:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
> 
> I don't know if it's worth the effort though.  Is any other driver likely
> to want to discriminate between reboot and shutdown?

e100 used to (and still does in 2.4) send the device into D3 on shutdown.
This causes problems on a number of boards if the box is only rebooting
as the driver fails to bring the device back out of D3.
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
