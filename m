Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264798AbSJaKXr>; Thu, 31 Oct 2002 05:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSJaKXr>; Thu, 31 Oct 2002 05:23:47 -0500
Received: from robur.slu.se ([130.238.98.12]:28683 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S264798AbSJaKXq>;
	Thu, 31 Oct 2002 05:23:46 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15809.2056.151239.230395@robur.slu.se>
Date: Thu, 31 Oct 2002 11:38:00 +0100
To: Lucio Maciel <abslucio@terra.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: [PATCH 2.5.44] Pktgen for 2.5.44
In-Reply-To: <1035921624.601.11.camel@walker>
References: <1035921624.601.11.camel@walker>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello...

> I have ported (integrated sounds better i think...) pktgen from
> 2.4.20-rc1 to 2.5.44...

> I only need to change current->need_resched to need_resched() in the
> source... works fine for me....

> I also correct the documentation changing multiskb to clone_skb
> best regards

Thanks!

There is also work going on with a "threaded" version with one process per CPU 
a la ksoftirqd. And to each thread/CPU you can add single or multiple devices.

But this work needs some more time. So your patch should be fine now.

Cheers.
						--ro

