Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263463AbTCNTTB>; Fri, 14 Mar 2003 14:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263464AbTCNTTB>; Fri, 14 Mar 2003 14:19:01 -0500
Received: from palrel12.hp.com ([156.153.255.237]:899 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S263463AbTCNTTA>;
	Fri, 14 Mar 2003 14:19:00 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15986.11687.17879.754719@napali.hpl.hp.com>
Date: Fri, 14 Mar 2003 11:29:43 -0800
To: Eric Piel <Eric.Piel@Bull.Net>
Cc: davidm@hpl.hp.com, linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org,
       Vitezslav Samel <samel@mail.cz>
Subject: Re: [Linux-ia64] Re: [BUG] nanosleep() granularity bumps up in 2.5.64 (was: [PATCH]
 settimeofday() not synchronised with gettimeofday())
In-Reply-To: <3E71E87C.10CBC8F7@Bull.Net>
References: <3E70B797.DFC260B@Bull.Net>
	<15984.58358.499539.299000@napali.hpl.hp.com>
	<3E71E87C.10CBC8F7@Bull.Net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 14 Mar 2003 15:34:36 +0100, Eric Piel <Eric.Piel@Bull.Net> said:

  Eric> Sure, I aim at porting the high resolution timers but any
  Eric> annoying bug related to the time can be interesting to remove.

Great!  It would be great to have someone who can focus on that.

  Eric> Any idea/sugestion/patch is welcomed. Whatever, I will try to
  Eric> fix this as soon as I'm back from my week end :-)

Does the x86 show the same behavior?  That would be a useful start to
narrow down the problem.

	--david
