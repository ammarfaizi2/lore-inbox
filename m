Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269984AbRHMI4S>; Mon, 13 Aug 2001 04:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269981AbRHMI4I>; Mon, 13 Aug 2001 04:56:08 -0400
Received: from mail.cogenit.fr ([195.68.53.173]:46726 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S269984AbRHMIzx>;
	Mon, 13 Aug 2001 04:55:53 -0400
Date: Mon, 13 Aug 2001 10:55:54 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast?
Message-ID: <20010813105554.A8387@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0108130303120.1037-100000@eriador.mirkwood.net>; from pf-kernel@mirkwood.net on Mon, Aug 13, 2001 at 03:43:05AM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PinkFreud <pf-kernel@mirkwood.net> :
[...]
> kernel!), to the system with the NCR 53c810 SCSI board, which suffered
> random kernel panics anywhere from 2 hours to 5 days after booting, due to
> the ncr53c8xx driver, to YET ANOTHER system which has shown a penchant for

The (ksymoops processed-) oopses may help. You can give a try at the
sym53c8xx driver. It performs well here:
- 53c875 adapter + BX + 2.4.3/2.4.7-ac11/2.4.8 + raid1 (small server)
- 53c810 + VP3 + 2.4.2 (instant reboot at startup with 2.4.8, I guess I
fscked some option).

[...]
> until 2.2.10!).  Furthermore, I have had a HELL of a time trying
> to get responses to the first two problems (this is the first report for
> the third).  It used to be that I could ask a question on this list, and
> receive responses.  Not anymore.  I can't seem to get the time of day from
> anyone on this list now.

Try and send specific bug-reports to the maintainers. 
l-k archives may give you some light on issues with VIA chipsets.

I'm not convinced that gaining stability on a VIA + G400 + X + smp 
combo is an easy task anyway.

-- 
Ueimor
