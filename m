Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282130AbRKWLoy>; Fri, 23 Nov 2001 06:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282128AbRKWLoe>; Fri, 23 Nov 2001 06:44:34 -0500
Received: from mx6.port.ru ([194.67.57.16]:36869 "EHLO smtp6.port.ru")
	by vger.kernel.org with ESMTP id <S282125AbRKWLoa>;
	Fri, 23 Nov 2001 06:44:30 -0500
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200111231147.fANBl7x11502@vegae.deep.net>
Subject: Re: [patch] scheduler cache affinity improvement in 2.4 kernels by Ingo Molnar
To: mingo@elte.hu
Date: Fri, 23 Nov 2001 14:47:06 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           So as i see the patch in question is being hit in its weakest
    place by that enormous 10 billion thread benchmark. 
    Indeed that weakest place is the added overhead which effects the
    heavy scheduling load.
      I look at it as at absolutely worst case. And even in this worst
    case we still have a win on a 8-way smp... I`d like to see some
    more real-life benchmarks on the issue...

      Maybe the tester lose the point, cause the patch was not pointed
   to improve the scheduling itself, but to reduce the loss of improper
   scheduling - ie cache thrashing.


cheers, Samium Gromoff
