Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135247AbRDRTHD>; Wed, 18 Apr 2001 15:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135253AbRDRTGy>; Wed, 18 Apr 2001 15:06:54 -0400
Received: from mail.fh-wedel.de ([195.37.86.23]:49670 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id <S135247AbRDRTGs>;
	Wed, 18 Apr 2001 15:06:48 -0400
Date: Wed, 18 Apr 2001 21:06:40 +0200
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugreport: Kernel 2.4.x crash
Message-ID: <20010418210640.A11446@wohnheim.fh-wedel.de>
In-Reply-To: <001a01c0bc4f$7de100f0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <001a01c0bc4f$7de100f0$5517fea9@local>; from manfred@colorfullife.com on Tue, Apr 03, 2001 at 05:05:14PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I have no experience with kernel debugging, but so far, I have found
> > no log entry giving me a hint and the screen is blank after the crash
> 
> Could you disable console blanking (setterm -blank 0).
> 
> We really need a hint where it crashed.

Over the easter weekend I took some time for testing. One ide channel does
not work with dma enabled, which is bootup default. After about 30 seconds,
the channel is switched to pio and the machine running again.

Funny though: Before, I could not return from console blanking or reach the
machine through network. But as for any production system, I rather keep it
running than spend downtime seeking the error.

Thank you all.

Jörn

-- 
Jörn Engel
mailto: joern@wohnheim.fh-wedel.de
http://wohnheim.fh-wedel.de/~joern
