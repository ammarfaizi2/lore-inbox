Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289353AbSBEIRg>; Tue, 5 Feb 2002 03:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289357AbSBEIR1>; Tue, 5 Feb 2002 03:17:27 -0500
Received: from pc1-camc5-0-cust78.cam.cable.ntl.com ([80.4.0.78]:36808 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S289354AbSBEIRM>;
	Tue, 5 Feb 2002 03:17:12 -0500
Message-Id: <m16Y0mA-000OVeC@amadeus.home.nl>
Date: Tue, 5 Feb 2002 08:16:26 +0000 (GMT)
From: arjan@fenrus.demon.nl
To: Oliver.Neukum@lrz.uni-muenchen.de
Subject: Re: current->state after kmalloc
cc: linux-kernel@vger.kernel.org
In-Reply-To: <16Xu62-2F1K08C@fwd04.sul.t-online.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <16Xu62-2F1K08C@fwd04.sul.t-online.com> you wrote:

> usb_submit_urb() uses kmalloc internally.
> To code a simple waiting for the results of an urb,
> it is necessary.

Can't you just alloc the memory outside this "current" area ?
Even if that means you have to release it if you don't use it
