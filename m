Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271793AbRHUSfk>; Tue, 21 Aug 2001 14:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271790AbRHUSfb>; Tue, 21 Aug 2001 14:35:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:45699 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S271793AbRHUSfX>; Tue, 21 Aug 2001 14:35:23 -0400
Date: Tue, 21 Aug 2001 14:35:34 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: James Simmons <jsimmons@transvirtual.com>
cc: Stephen Satchell <satch@fluent-access.com>, <linux-kernel@vger.kernel.org>
Subject: Re: FYI  PS/2 Mouse problems -- userland issue
In-Reply-To: <Pine.LNX.4.10.10108211126380.20205-100000@transvirtual.com>
Message-ID: <Pine.LNX.4.33.0108211432530.14374-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, James Simmons wrote:

> Their already is a replacement driver using the input api avaliable that I
> was planning to intergrate into 2.5. It fixed alot of the issues people
> are having now.

Whether it uses the input api or the existing scheme doesn't matter to me.
What's important is that the interrupt disables and udelay()'s are
removed, so I'll gladly merge my work with whatever else people have
prepared.  I would've done it sooner, but changing the keyboard driver is
an area of compatibility with sufficiently many hazzards that it's not
reasonable for 2.4.

		-ben

