Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262797AbRE3OCj>; Wed, 30 May 2001 10:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbRE3OCT>; Wed, 30 May 2001 10:02:19 -0400
Received: from chiara.elte.hu ([157.181.150.200]:11787 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S262797AbRE3OCK>;
	Wed, 30 May 2001 10:02:10 -0400
Date: Wed, 30 May 2001 16:00:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Nico Schottelius <nicos@pcsystems.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ PATCH ]: disable pcspeaker kernel: 2.4.2 - 2.4.5
Message-ID: <Pine.LNX.4.33.0105301559310.1240-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> less code / one int more in the kernel
> or
> more code and #ifs / one int less in the kernel

if the #ifdefs bloat the code 4 times the size of the simple patch, then
we obviously want 4 bytes more in the kernel.

> And what about the code from kernel/sys.c ? The version you provided
> doesn't take care of what's the default value of pcspeaker. This would
> make it undefined, which is not really good.

the default value is 0, that is good enough.

	Ingo

