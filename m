Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263911AbTCUTr4>; Fri, 21 Mar 2003 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263892AbTCUTq5>; Fri, 21 Mar 2003 14:46:57 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:65409 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263897AbTCUTqJ>; Fri, 21 Mar 2003 14:46:09 -0500
Date: Fri, 21 Mar 2003 12:56:29 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2 (fwd)
Message-ID: <413100000.1048276588@aslan.btc.adaptec.com>
In-Reply-To: <Pine.LNX.4.50.0303210232340.2133-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com> <Pine.LNX.4.50.0303210232340.2133-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, 21 Mar 2003, Zwane Mwaikambo wrote:
> 
>> Hi Justin i got this booting 2.5.65-mm2, 2.5.65 was fine there is an oops 
>> right at the end. Is there anything specific you want?
> 
> Correction, 2.5.65 isn't ok (both aic7xxx and aic7xxx_old die although 
> aic7xxx not as ceremoniously). I do know that 2.5.53 is ok so i'll try and 
> find the suspect kernel.

One other thing to consider is if interrupts are working for you with
later kernels.  The 2.5.X aic79xx src tarball should work in 2.5.53 and
2.5.65, so if the same driver rev works in one kernel but not the other,
then you can quickly exonerate the driver.

--
Justin

