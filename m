Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284765AbRLPS0V>; Sun, 16 Dec 2001 13:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284763AbRLPS0M>; Sun, 16 Dec 2001 13:26:12 -0500
Received: from mail.eunet.ch ([146.228.10.7]:29957 "EHLO mail.kpnqwest.ch")
	by vger.kernel.org with ESMTP id <S284762AbRLPSZw>;
	Sun, 16 Dec 2001 13:25:52 -0500
Message-ID: <3C1CF53D.B88065FC@dial.eunet.ch>
Date: Sun, 16 Dec 2001 19:25:49 +0000
From: Mario Vanoni <vanonim@dial.eunet.ch>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-rc1aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IMHO integrate _please_ Andrea's patches 100%.

Dual SMP PIII550 with 1024MB memory CAS 2-2-2.

Reason: latency, <30% with Andrea.

Test: time qsbench -p 9 (Lorenzo Allegrucci):
      rc1aa1 resolves the latency in
      <30% the time with 120MB swap,
      <20% _without_ swap space present!

      time qsbench reaches 5m44.204s with rc1,
      <= 2.44.025s with rc1aa1,
      test a login in that time ..., wait Godot!

      Without swap the times are:
      <= 3m41.720s with rc1,
      <= 2m43.090s with rc1aa1.

What is better if e.g. a "qsbench" occusr,
wait 5 or 3 minutes for a response?

I run my 3xUP and 1xSMP normally _without_ swap,
all with lots of memory.

Note: this with or without 2 (two) setiathome
      24/7 on the SMP + all abitual work.
      See setiathome country Switzerland under
      Mario Vanoni, about place 87.

Kind regards

Mario, _not_ in lkml.
