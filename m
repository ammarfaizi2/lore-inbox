Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129860AbRCCXgD>; Sat, 3 Mar 2001 18:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRCCXfx>; Sat, 3 Mar 2001 18:35:53 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27404 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129860AbRCCXfn>; Sat, 3 Mar 2001 18:35:43 -0500
Subject: Re: RFC: changing precision control setting in initial FPU context
To: buhr@stat.wisc.edu (Kevin Buhr)
Date: Sat, 3 Mar 2001 23:37:45 +0000 (GMT)
Cc: adam@yggdrasil.com (Adam J. Richter), drepper@cygnus.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <vbaofviqvm6.fsf@mozart.stat.wisc.edu> from "Kevin Buhr" at Mar 03, 2001 05:29:53 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZLat-0004Js-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> with GCC's 64-bit doubles (and its 64-bit clean but 80-bit dirty
> floating point optimizations), so I'm proposing adding an instruction
> to "init_fpu()" to change the default hardware control word.

You want peoples existing applications to suddenely and magically change
their results. Umm problem. If your app needs a specific control word then
just force it in the app

