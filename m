Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287497AbRLaMSA>; Mon, 31 Dec 2001 07:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287492AbRLaMRv>; Mon, 31 Dec 2001 07:17:51 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:41996 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S287495AbRLaMRn>; Mon, 31 Dec 2001 07:17:43 -0500
Message-Id: <4.3.2.7.2.20011231121112.00b0e940@192.168.124.1>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 31 Dec 2001 12:16:57 +0000
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: Roy Hills <linux-kernel-l@nta-monitor.com>
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <a0ie3s$s71$1@cesium.transmeta.com>
In-Reply-To: <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
 <20011228121228.GA9920@emma1.emma.line.org>
 <4.3.2.7.2.20011228124704.00abba70@192.168.124.1>
 <4.3.2.7.2.20011228173505.00aa3da0@192.168.124.1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:36 28/12/01 -0800, H. Peter Anvin wrote:
>I believe this is now a myth.  Toshiba's weird A20 problems should
>have been worked around for a long, long time; and I believe the
>latest set of changes in 2.4 should make that thouroughly complete.
>In fact, if your bzImages don't work either, I suspect your problems
>isn't at all one of zImage vs bzImage but that there is a separate bug
>that's biting you independently.

You're right - I've just done a "make bzImage" on the same .config
file and the resulting kernel boots fine on my Tecra!

I'm a happy bunny now because I can just use bzImage for all my
systems.

So it looks like the Tecra A20 problem was worked around some
time ago, it's just that I remember the days when it wasn't and had
learnt the zImage workaround.

Thanks for pointing me in the right direction.  I really don't know why
I didn't just try bzImage before.

Although the Tecra problem has been solved, the zImage bug remains,
although I'm not concerned about it now that I can use bzImage.

Roy Hills

--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/

