Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUA3Ojj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUA3Ojj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:39:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16535 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261188AbUA3Oji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:39:38 -0500
Date: Fri, 30 Jan 2004 09:39:30 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: R CHAN <rspchan@starhub.net.sg>
cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [CRYPTO]: Miscompiling sha256.c by gcc 3.2.3 and arch pentium3,4
In-Reply-To: <4019CDBC.3060900@starhub.net.sg>
Message-ID: <Xine.LNX.4.44.0401300939070.15830-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jan 2004, R CHAN wrote:

> 2.6.2-rc2 sha256.c is miscompiled with gcc 3.2.3.
> (User space is RedHat 3ES.)
> 
> Just an observation:
> 
> gcc 3.2.3 is miscompiling sha256.c when using
> -O2 -march=pentium3
> or pentium4.
> 
> gcc 3.3.x is ok, or the problem disappears
> if I use arch=i686 or reduce the optimisation level to -O2.
> 
> Sympthoms are all the sha256 test vectors fail.
> If I extract the guts of the file to compile in user space
> the same problem occurs.

Have you noticed if this happens for any of the other crypto algorithms?



- James
-- 
James Morris
<jmorris@redhat.com>


