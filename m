Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWJHO3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWJHO3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 10:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWJHO3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 10:29:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:12505 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751196AbWJHO3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 10:29:21 -0400
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Date: Sun, 8 Oct 2006 16:28:54 +0200
User-Agent: KMail/1.9.4
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608131815.12873.mlkernel@mortal-soul.de> <20061006175833.4ef08f06@localhost>
In-Reply-To: <20061006175833.4ef08f06@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610081628.55012.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 6. Oktober 2006 17:58 schrieb Paolo Ornati:
> On Sun, 13 Aug 2006 18:15:12 +0200
>
> Matthias Dahl <mlkernel@mortal-soul.de> wrote:
> > Just let me know once you got them, so I can safely delete them again.
> >
> > At the moment, I am trying without preemption but for example doing a
> > untar kernel sources still results in sluggish system responsiveness. :-(
>
> I used to have this type of problem and 2.6.19-rc1 looks much better
> than 2.6.18.
>
> I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> and /proc/sys/vm/swappiness = 20.


Which change in the new kernel has made it better? I was following the lkml 
very close and didn't see any change that could have fixed that problem.

- Christian
