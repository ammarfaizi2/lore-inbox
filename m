Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTJGPrR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbTJGPrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 11:47:17 -0400
Received: from [38.119.218.103] ([38.119.218.103]:4833 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S261240AbTJGPrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 11:47:16 -0400
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.040205 secs)
Date: Tue, 7 Oct 2003 10:47:12 -0500
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test6[-mm4] boot failure on alpha
Message-ID: <20031007154712.GA13741@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031006235759.GA26127@wang-fu.org> <20031007105116.A616@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031007105116.A616@den.park.msu.ru>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus spake Ivan Kokshaysky:
> Can you reproduce that with "nosmp" on boot command line?

With nosmp, it still appears to hang in the same place:

SMP mode deactivated. 
Starting migration thread for cpu 0
CPUS done 0
SMP: Total of 1 processors activated (548.29 BogoMIPS).
NET: Registered protocol family 16
EISA bus registered
PCI: Bus 1, bridge: 0000:00:07.0
  IO window: 9000-9fff
  MEM window: 01100000-011fffff
  PREFETCH window: disabled.
PCI: Bus 2, bridge: 0000:00:08.0


-- 
Nathan Poznick <kraken@drunkmonkey.org>

"This man must have led a very full and active life..." "'Cause he's
got a squirrel in his stomach!" -Dr. Raeburn/Crow (as Dr. Raeburn).
#206

