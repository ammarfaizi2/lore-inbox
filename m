Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSE1C5P>; Mon, 27 May 2002 22:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSE1C5O>; Mon, 27 May 2002 22:57:14 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:1987 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S311752AbSE1C5O>; Mon, 27 May 2002 22:57:14 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 May 2002 11:55:47 +0900
Message-ID: <buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:
> The kernel can only be compiled with gcc, but some bits of the build
> are compiled and run on the host, using the host compiler.  Avoid using
> gccisms where there is a standard way of doing it.

That particular gccism completely infests the kernel, so there seems
little point in avoiding it in favor of the uglier standard syntax.

-Miles
-- 
I have seen the enemy, and he is us.  -- Pogo
