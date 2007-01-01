Return-Path: <linux-kernel-owner+w=401wt.eu-S1754748AbXAAXbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbXAAXbH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbXAAXbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:31:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46363 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754748AbXAAXbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:31:06 -0500
Date: Mon, 1 Jan 2007 15:30:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@gmail.com>, Jens Axboe <jens.axboe@oracle.com>
cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
In-Reply-To: <45999191.8020004@gmail.com>
Message-ID: <Pine.LNX.4.64.0701011530141.4473@woody.osdl.org>
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com>
 <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com>
 <45999191.8020004@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Jan 2007, Rene Herman wrote:

> Rene Herman wrote:
> 
> > In fact, it's CFQ. The PATA thing was a red herring. 2.6.20-rc2 and 3 give
> > me ~ 24 MB/s from "hdparm t /dev/hda" while 2.6.20-rc1 and below give me ~
> > 50 MB/s.
> > 
> > Jens: this is due to "[PATCH] cfq-iosched: tighten allow merge criteria",
> > 719d34027e1a186e46a3952e8a24bf91ecc33837:
> 
> axboe@oracle.com bounces for me. Could one of the other recipients of parent
> message try to forward?

It should be "Jens Axboe <jens.axboe@oracle.com>". 

Jens was away over the holidays, hopefully he'll be back today or 
tomorrow.

		Linus
