Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263010AbTC1PWL>; Fri, 28 Mar 2003 10:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263015AbTC1PWL>; Fri, 28 Mar 2003 10:22:11 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61671 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263010AbTC1PWK>;
	Fri, 28 Mar 2003 10:22:10 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 28 Mar 2003 16:33:25 +0100 (MET)
Message-Id: <UTC200303281533.h2SFXPP00799.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: 64-bit kdev_t - just for playing
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    On Fri, 28 Mar 2003 Andries.Brouwer@cwi.nl wrote:

    > > the actual size of this number is only a small detail
    > 
    > Yes. It is that detail I am concerned with.

    If you don't want to or can't answer my question, it means I can revert 
    your character device changes?

I am not Linus. You can send him whatever you think best
and see whether he applies it.

I would prefer if you waited a bit. This little detail,
changing the size of dev_t, requires an audit of the
kernel source. That takes some time.
I would much prefer postponing discussion about device
handling until after number handling is in good shape.

Generally it is a bad idea when two people simultaneously
change the same code.

Andries


