Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261352AbSIZQA2>; Thu, 26 Sep 2002 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSIZQA1>; Thu, 26 Sep 2002 12:00:27 -0400
Received: from [66.70.28.20] ([66.70.28.20]:56850 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261352AbSIZQAZ>; Thu, 26 Sep 2002 12:00:25 -0400
Date: Thu, 26 Sep 2002 18:14:24 +0200
From: DervishD <raul@pleyades.net>
To: immortal1015 <immortal1015@52mail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A newbie's question
Message-ID: <20020926161424.GF47@DervishD>
References: <20020926144558Z261317-8740+1711@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020926144558Z261317-8740+1711@vger.kernel.org>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi unknown :)

> 	rep
> 	movw

    In my bootsector.S, it's movsw: repeat move (string) by words.
'movw' is 'mov word size operands'.

> 	jmpi	go,INITSEG

    AFAIK, the correct is 'ljmp': long jump. What kernel sources are
you seeing?. Old kernels (2.0 and I think that 2.2 too) used as86 to
do the assembling, and the syntax was like the Intel one, but with
some differences. Not quite standard, I think.

> /////////////////////////////
> 1. What assembly language used in boot.s? Intel Asm or AT&T?

    AT&T in new kernels, fully 'assembleable' with GNU as. IMHO is a
better syntax, but I don't want to feed a troll here ;)

> 2. Where is the definition of operand movw and jmpi?
> I cant find it in the Intel Manual.

    Of course, there aren't Intel syntax anyway :) I recommend you to
see the 2.4 sources for reading the assembler part. Moreover, the
info section for 'GNU as' comments the differences between Intel
assembly syntax and the AT&T one. This will be of great help.

    In addition to this, I have a document about using GNU as for
real mode assembly that comments some of these points. But it is
written in spanish only :((

    Last, the Assembly-HOWTO will cast some light to the issue, too.

    Raúl
