Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130541AbRCIQiS>; Fri, 9 Mar 2001 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130542AbRCIQiJ>; Fri, 9 Mar 2001 11:38:09 -0500
Received: from vp175062.reshsg.uci.edu ([128.195.175.62]:65287 "EHLO
	moisil.dev.hydraweb.com") by vger.kernel.org with ESMTP
	id <S130541AbRCIQh4>; Fri, 9 Mar 2001 11:37:56 -0500
Date: Fri, 9 Mar 2001 08:35:48 -0800
Message-Id: <200103091635.f29GZmC19160@moisil.dev.hydraweb.com>
From: Ion Badulescu <ionut@moisil.cs.columbia.edu>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@elte.hu>, Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: <3AA8E6E5.A4AD5035@uow.edu.au>
User-Agent: tin/1.5.7-20001104 ("Paradise Regained") (UNIX) (Linux/2.2.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Mar 2001 01:21:25 +1100, Andrew Morton <andrewm@uow.edu.au> wrote:

> +/**
> + * enable_nmi_watchdog - enables/disables NMI watchdog checking.
> + * @yes: If zero, disable

Ugh. I have a feeling that your chances to get Linus to accept this are
extremely slim.

Just have two functions, enable_nmi_watchdog and disable_nmi_watchdog.
You can make them inline, or even macros...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
