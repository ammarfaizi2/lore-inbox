Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133006AbRDKWm6>; Wed, 11 Apr 2001 18:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133010AbRDKWmt>; Wed, 11 Apr 2001 18:42:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:28690 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S133006AbRDKWmm>; Wed, 11 Apr 2001 18:42:42 -0400
Message-ID: <3AD4DDC7.99017C15@transmeta.com>
Date: Wed, 11 Apr 2001 15:42:15 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 rw_semaphores fix
In-Reply-To: <E14nSl8-0007e9-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Yes, the big 686 optimization is CMOV, and that one is
> > ultra-pervasive.
> 
> Be careful there. CMOV is an optional instruction. gcc is arguably wrong
> in using cmov in '686' mode. Building libs with cmov makes sense though
> especially for the PIV with its ridiculously long pipeline
> 

It is just a matter how you define "686 mode", otherwise the very concept
is meaningless.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
