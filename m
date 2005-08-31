Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVHaEbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHaEbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVHaEbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:31:49 -0400
Received: from dial169-151.awalnet.net ([213.184.169.151]:55303 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S932343AbVHaEbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:31:49 -0400
From: Al Boldi <a1426z@gawab.com>
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Subject: Re: Where is the performance bottleneck?
Date: Wed, 31 Aug 2005 07:30:38 -0300
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de> <200508292310.39903.a1426z@gawab.com> <Pine.LNX.4.61.0508301909220.25574@diagnostix.dwd.de>
In-Reply-To: <Pine.LNX.4.61.0508301909220.25574@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508310730.38112.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holger Kiehl wrote:
> On Mon, 29 Aug 2005, Al Boldi wrote:
> > You may be hitting a 2.6 kernel bug, which has something to do with
> > readahead, ask Jens Axboe about it! (see "[git patches] IDE update"
> > thread) Sadly, 2.6.13 did not fix it either.
>
> I did read that threat, but due to my limited understanding about kernel
> code, don't see the relation to my problem.

Basically the kernel is loosing CPU cycles while accessing bockdevices.
The problem shows most when the CPU/DISK ratio is low.
Throwing more CPU cycles at the problem may seemingly remove this bottleneck.

> But I am willing to try any patches to solve the problem.

No patches yet.

> > Did you try 2.4.31?
>
> No. Will give this a try if the problem is not found.

Keep us posted!

--
Al
