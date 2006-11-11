Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424599AbWKKSiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424599AbWKKSiM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 13:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946102AbWKKSiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 13:38:12 -0500
Received: from ns2.g-housing.de ([81.169.133.75]:12727 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1424599AbWKKSiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 13:38:11 -0500
Date: Sat, 11 Nov 2006 18:38:05 +0000 (GMT)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Adrian Bunk <bunk@stusta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: OOM in 2.6.19-rc*
In-Reply-To: <20061111181937.GC25057@stusta.de>
Message-ID: <Pine.LNX.4.64.0611111832180.1247@sheep.housecafe.de>
References: <Pine.LNX.4.64.0611111318230.1247@sheep.housecafe.de>
 <20061111181937.GC25057@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2006, Adrian Bunk wrote:
> Can you test whether an older kernel (preferably the one that worked
> before) shows the same problem?

I could try 2.6.17...but currently I don't know how to reproduce the OOM 
condition - so I'd have to wait 24h until *something* happens and the 
OOM killer kicks in.

> This way you might know whether it's a kernel problem or a distribution
> problem.

I think I'm more interested as to why the OOM killer seems to kill 
innocent apps at random. I can imagine that it's not easy for the kernel 
to tell which userland-application is using up too much memory. Hm, 
egrep -r "OOM|ut of memory" Documentation/    does not reveal much :(

Thanks,
Christian.
-- 
BOFH excuse #362:

Plasma conduit breach
