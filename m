Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbRD1O0v>; Sat, 28 Apr 2001 10:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132914AbRD1O0m>; Sat, 28 Apr 2001 10:26:42 -0400
Received: from viper.haque.net ([66.88.179.82]:64129 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S132909AbRD1O0Z>;
	Sat, 28 Apr 2001 10:26:25 -0400
Message-ID: <3AEAD305.6ADC22F2@haque.net>
Date: Sat, 28 Apr 2001 10:26:13 -0400
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <peter.osterlund@mailbox.swipnet.se>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> I have noticed that 2.4.4 feels a lot less responsive than 2.4.3 under
> fork load. This is caused by the "run child first after fork" patch. I
> have tested on two different UP x86 systems running redhat 7.0.
> 
> For example, when running the gcc configure script, the X mouse pointer is
> very jerky. The configure script itself runs approximately as fast as in
> 2.4.3.
> 
> Another thing is that the bash loop "while true ; do /bin/true ; done" is
> not possible to interrupt with ctrl-c.
> 

Just as a data point, I'm experiencing this also.

> Reverting the fork patch makes all these problems go away on my machine.
> I'm not saying that this is necessarily a good idea, that patch might be
> good for other reasons.

I'll try out this patch soon.
-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
