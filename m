Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSIXHQn>; Tue, 24 Sep 2002 03:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSIXHQn>; Tue, 24 Sep 2002 03:16:43 -0400
Received: from paperboy.noris.net ([62.128.1.27]:63140 "EHLO mail2.noris.net")
	by vger.kernel.org with ESMTP id <S261594AbSIXHQm>;
	Tue, 24 Sep 2002 03:16:42 -0400
Mime-Version: 1.0
Message-Id: <p05111701b9b4f24d964e@[192.109.102.36]>
Date: Mon, 23 Sep 2002 18:36:02 +0200
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@noris.de>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waechtler:
>  [ unattributed -- please don't discard attributions ]

>  Having multiple threads doing real work including IO means more
>  blocking IO and therefore more context switches.

On the other hand, having to multiplex in userspace requires calls to 
poll() et al, _and_ explicitly handling state which the kernel needs 
to handle anyway -- including locking and all that crap.

Given that an efficient and fairly-low-cost 1:1 implementation is 
demonstrably possible ;-) the necessity to do any kind of n:m work 
strikes me as extremely low.
-- 
Matthias Urlichs      http://smurf.noris.de     ICQ:20193661    AIM:smurfixx
