Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279951AbRKSQLu>; Mon, 19 Nov 2001 11:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279927AbRKSQLa>; Mon, 19 Nov 2001 11:11:30 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:35338 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S277012AbRKSQL2>; Mon, 19 Nov 2001 11:11:28 -0500
Date: Mon, 19 Nov 2001 11:11:20 -0500
Message-Id: <200111191611.fAJGBKQ30686@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
X-Newsgroups: linux.kernel
In-Reply-To: <3BF32B36.8B1375D0@neo.shinko.co.jp>
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Reply-To: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BF32B36.8B1375D0@neo.shinko.co.jp> nakai@neo.shinko.co.jp wrote:
>I think you'd be better compile kernel for K6, not for K7.  There is
>something wrong with KT133 chip set and Athlon/Duron.

There is a patch for this chipset around, which AFAIK was never put in
the kernel because the exact function of the patch was not known WRT the
chipset internals. None the less, without it my Athlon systems won't run
an Athlon compiled kernel, and while a P6 kernel will boot,
Athlon-optimized user software will hang the system. Since that's not
acceptable I run the patch. You should be able to find it on this list
in the archives.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
