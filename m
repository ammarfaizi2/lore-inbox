Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRDKSGr>; Wed, 11 Apr 2001 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132695AbRDKSGh>; Wed, 11 Apr 2001 14:06:37 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12562 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132690AbRDKSGb>; Wed, 11 Apr 2001 14:06:31 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] i386 rw_semaphores fix
Date: 11 Apr 2001 11:06:13 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9b26el$3tr$1@cesium.transmeta.com>
In-Reply-To: <20010411020058.B28670@gruyere.muc.suse.de> <E14nJjm-0006X8-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E14nJjm-0006X8-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
> > 
> > Yes, and with CMPXCHG handler in the kernel it wouldn't be needed 
> > (the other 686 optimizations like memcpy also work on 386) 
> 
> They would still be needed. The 686 built glibc materially improves performance
> on 686 class machines. That one isnt an interesting problem to solve. Install
> the right software instead.
> 

Yes, the big 686 optimization is CMOV, and that one is
ultra-pervasive.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
