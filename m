Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266489AbUGBHdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266489AbUGBHdz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 03:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUGBHdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 03:33:55 -0400
Received: from bart.webpack.hosteurope.de ([217.115.142.76]:13699 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S266492AbUGBHdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 03:33:53 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Fri, 2 Jul 2004 09:39:47 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Andrew Morton <akpm@osdl.org>
cc: Jean Tourrilhes <jt@hpl.hp.com>, Yichen Xie <yxie@cs.stanford.edu>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUGS] [CHECKER] 99 synchronization bugs and a lock summary
 database
In-Reply-To: <20040701213837.0b97c21e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407020929130.25211-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-HE-MXrcvd: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2004, Andrew Morton wrote:

>    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/stanford-locking-bugs/
> 
> so we can keep track of which of these possible bugs has been fixed or
> otherwise disposed of.

---
err2-4
[NOTE] BUG (line 182)
ERROR: AMBIGUOUS OUTSTATE:
drivers/net/irda/sir-dev.h:sirdev_write_complete
<http://glide.stanford.edu/cgi-bin/linux-lock/findsum.pl?
function=drivers/net/irda/sir-dev.h:sirdev_write_complete>:
*param_0(dev).tx_lock
---

Was real bug. Already fixed in 2.6.7.

Thanks,
Martin

