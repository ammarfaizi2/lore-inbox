Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275385AbTHNTdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275393AbTHNTdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 15:33:52 -0400
Received: from blackhole.kfki.hu ([148.6.0.114]:2310 "EHLO blackhole.kfki.hu")
	by vger.kernel.org with ESMTP id S275385AbTHNTdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 15:33:22 -0400
Date: Thu, 14 Aug 2003 21:33:20 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: kmem_cache_destroy: Can't free all objects (2.6)
In-Reply-To: <3F3BB38F.6060506@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0308142131130.8530-100000@blackhole.kfki.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Aug 2003, Philippe Elie wrote:

> > This happens both with 2.5.74 and 2.6.0-test1.
>
> I fixed a bug with exactly this symptom, all object freed but
> the cache was retaining some object internally. I look 2.6.0-test1
> and the fix is in, apologies if you already did it correctly
> but can you double check the bug is really in 2.6.0-test1.

Yes. Before I posted my mail I googled a lot and found your fix. I
checked the source of 2.6.0-test1 and your fix is there of course.

Best regards,
Jozsef
-
E-mail  : kadlec@blackhole.kfki.hu, kadlec@sunserv.kfki.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : KFKI Research Institute for Particle and Nuclear Physics
          H-1525 Budapest 114, POB. 49, Hungary

