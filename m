Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbRGRWd3>; Wed, 18 Jul 2001 18:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGRWdT>; Wed, 18 Jul 2001 18:33:19 -0400
Received: from d-dialin-2958.addcom.de ([213.61.82.78]:42222 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263089AbRGRWdI>; Wed, 18 Jul 2001 18:33:08 -0400
Date: Thu, 19 Jul 2001 00:25:26 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, Julian Anastasov <ja@ssi.bg>
Subject: Re: cpuid_eax damages registers (2.4.7pre7)
In-Reply-To: <200107182204.f6IM4K001282@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0107190023220.28109-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Linus Torvalds wrote:

> Can you verify with this alternate patch instead? Yours works ok on
> older gcc's, but the gcc team feels that clobbers must never cover
> inputs or outputs, so your patch really generates invalid asms.  Here's
> a alternate, can you verify that it works for you guys, and perhaps
> people can at the same time eye-ball it for any other issues they can
> think of?

Generated code looks good here. I checked the asm output for some 
instances of cpuid_e[acd]x() in setup.c, and generated asm looks right in 
all cases.

--Kai
 

