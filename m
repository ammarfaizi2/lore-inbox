Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbRGHH2y>; Sun, 8 Jul 2001 03:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266795AbRGHH2o>; Sun, 8 Jul 2001 03:28:44 -0400
Received: from metastasis.f00f.org ([203.167.249.89]:7042 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266750AbRGHH2h>;
	Sun, 8 Jul 2001 03:28:37 -0400
Date: Sun, 8 Jul 2001 19:28:05 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vibol Hou <vhou@khmer.cc>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
Message-ID: <20010708192805.C26213@weta.f00f.org>
In-Reply-To: <E15IzpL-0006Hq-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15IzpL-0006Hq-00@the-village.bc.nu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2001 at 10:41:23PM +0100, Alan Cox wrote:

    It means your processor flagged a fault. The b2....115 number
    decodes to info about the fault cause if you grab the PIII manual.

    Stupid things like overheating. wrong voltages can also trigger it

Is there any reason why, with proper MCE checking for both K7 and PIII
we can't automatically off-line processors when they start doing bad
things?

Sure, its a pretty lousy thing to do, but if you buys you a few
minutes and allows userland to initiate some kind of remedy
(pager("HELP"); system("shutdown"); sort of thing)...

Also, I'm pretty sure I was seeing overheating problems or something
on a K7 at one point, but never saw MCE; I take it this code only
exists fully in -ac kernels? I looked in Linus' tree and couldn't see
anything.




  --cw
