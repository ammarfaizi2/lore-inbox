Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282271AbRKWWnu>; Fri, 23 Nov 2001 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282272AbRKWWnk>; Fri, 23 Nov 2001 17:43:40 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:6016 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282271AbRKWWnY>;
	Fri, 23 Nov 2001 17:43:24 -0500
Message-ID: <3BFED107.CBAAFC37@pobox.com>
Date: Fri, 23 Nov 2001 14:43:19 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sunrpc woes with tux2 in 2.4.15-pre8,9
In-Reply-To: <Pine.LNX.4.33.0111231153160.3988-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> On Thu, 22 Nov 2001, J Sloan wrote:
>
> > In 2.4.15-pre8 I applied the tux2 patches to
> > take it for a spin - well, it's insanely fast, thanks
> > Ingo - but I am having a problem with the sun
> > rpc module:
>
> > depmod: *** Unresolved symbols in
> > depmod:         atomic_dec_and_lock_R648ef859
>
> hm, it's exported. What does 'grep dec_and_lock /proc/ksyms' show on your
> box?

Well, the problem is it's there because of tux2,
but never defined since I compiled for up -

If I compile with smp enabled the problem
disappears - but I naturally prefer maximum
efficiency, so I usually compile smp enabled
kernels only on smp boxes.

cu

jjs


