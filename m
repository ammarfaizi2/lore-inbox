Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbVIZRdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbVIZRdd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 13:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbVIZRdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 13:33:33 -0400
Received: from [212.76.86.33] ([212.76.86.33]:4612 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751694AbVIZRdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 13:33:32 -0400
From: Al Boldi <a1426z@gawab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Resource limits
Date: Mon, 26 Sep 2005 20:32:12 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <EXCHG2003ogxLDp7mvj00000ae4@EXCHG2003.microtech-ks.com> <1127754691.27757.26.camel@localhost.localdomain>
In-Reply-To: <1127754691.27757.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509262032.12081.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-09-26 at 09:44 -0500, Roger Heflin wrote:
> > While talking about limits, one of my customers report that if
> > they set "ulimit -d" to be say 8GB, and then a program goes and
>
> The kernel doesn't yet support rlimit64() - glibc does but it emulates
> it best effort. Thats a good intro project for someone
>
> > It would seem that the best thing to do would be to abort on
> > allocates that will by themselves exceed the limit.
>
> 2.6 supports "no overcommit" modes.

By name only.  see "Kswapd flaw" thread.

Thanks!

--
Al

