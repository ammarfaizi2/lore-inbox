Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261792AbTCQP6s>; Mon, 17 Mar 2003 10:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261794AbTCQP6s>; Mon, 17 Mar 2003 10:58:48 -0500
Received: from asmtp1.prserv.net ([32.97.166.51]:5114 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id <S261792AbTCQP6r>;
	Mon, 17 Mar 2003 10:58:47 -0500
Message-Id: <5.1.0.14.0.20030317110757.00b08f00@pop.business.earthlink.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 17 Mar 2003 11:09:35 -0500
To: Duncan Sands <baldrick@wanadoo.fr>, Karl Vogel <karl.vogel@seagha.com>,
       linux-kernel@vger.kernel.org
From: Jim Peterson <jpeterson@annapmicro.com>
Subject: Re: v2.5.32 - v2.5.64+ Locks at Boot with Athlon Machine
In-Reply-To: <200303151445.57486.baldrick@wanadoo.fr>
References: <E18tnzg-0007Zf-00@relay-1.seagha.com>
 <5.1.0.14.0.20030312104635.022b1178@shrek>
 <E18tnzg-0007Zf-00@relay-1.seagha.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:45 PM 3/15/2003 +0100, Duncan Sands wrote:
>Did you turn on console support in your .config?
>        CONFIG_VT=y
>        CONFIG_VT_CONSOLE=y
>You will need to compile input support into the kernel (i.e. not as a module):
>        CONFIG_INPUT=y
>I hope this helps,

Drat!

  This was indeed the problem.  I'm not sure how my .config file lost that setting.
  Anyhow, I'm now happily running 2.5.64.  Sorry for the trouble.

Thank you,
--Jim

