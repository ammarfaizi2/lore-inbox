Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263104AbUCMOfi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbUCMOfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:35:36 -0500
Received: from cibs9.sns.it ([192.167.206.29]:16394 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id S263104AbUCMOfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:35:34 -0500
Date: Sat, 13 Mar 2004 15:34:57 +0100 (CET)
From: venom@sns.it
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NVIDIA and 2.6.4?
In-Reply-To: <20040311131027.051055D9A@mx.ktv.lt>
Message-ID: <Pine.LNX.4.43.0403131532170.26664-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on x86 all nvidia driver will compile and run with 2.6 kernels using nimion
patches.

nvidia driver on 2.6.4 won't run if you compile the kernel with
-mregparm=3 (CONFIG_REGPARM enabled). Then you will get the most wonderfull oops
of your life.

bests
Luigi


On Thu, 11 Mar 2004, Nerijus Baliunas wrote:

> Date: Thu, 11 Mar 2004 15:07:03 +0200 (EET)
> From: Nerijus Baliunas <nerijus@users.sourceforge.net>
> To: Robert L. Harris <Robert.L.Harris@rdlg.net>
> Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
> Subject: Re: NVIDIA and 2.6.4?
>
> On Thu, 11 Mar 2004 07:31:00 -0500 "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
>
> > And that's just for starters.  Does anyone know if there's a way to get
> > this to compile cleanly or is it SoL until a new driver is released
> > (running 1.0.4191 currently).
>
> At least for x86 the latest driver (1.0-5336) is compatible with 2.6.x
> (didn't test on 2.6.4 though).
>
> Regards,
> Nerijus
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

