Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTJJJKH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 05:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJJJKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 05:10:07 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:46284 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262729AbTJJJKE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 05:10:04 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 10 Oct 2003 11:09:55 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6-test7] [bttv] lots of warning/error messages
Message-ID: <20031010090955.GE32386@bytesex.org>
References: <200310091729.30465.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310091729.30465.mbuesch@freenet.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> get lots of warning/error messages from the bttv driver.
> Here are todays messages:
> 
> Oct  9 15:51:13 lfs kernel: bttv0: skipped frame. no signal? high irq latency?
> Oct  9 15:57:57 lfs kernel: bttv0: OCERR @ 1fd95000,bits: HSYNC OFLOW OCERR*

Hmm.  Is the signal good?

> I'm using a preemptible kernel.
> Should I try it again with preemptible disabled?

I would be surprised if CONFIG_PREMPT on/off makes a difference, looks
more like a hardware issue to me.  Neverless it's worth a try.  

  Gerd

