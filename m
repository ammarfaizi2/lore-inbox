Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318691AbSG0DnM>; Fri, 26 Jul 2002 23:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318692AbSG0DnM>; Fri, 26 Jul 2002 23:43:12 -0400
Received: from domino1.resilience.com ([209.245.157.33]:40400 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S318691AbSG0DnM>; Fri, 26 Jul 2002 23:43:12 -0400
Mime-Version: 1.0
Message-Id: <p05111a0fb967c6b3e8d9@[10.128.7.49]>
In-Reply-To: <1027735557.15951.3.camel@irongate.swansea.linux.org.uk>
References: <5009AD9521A8D41198EE00805F85F18F219A7E@sembo111.teknor.com> 
 <3D41C544.9090702@unix.sh>
 <1027735557.15951.3.camel@irongate.swansea.linux.org.uk>
Date: Fri, 26 Jul 2002 20:44:27 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Handling NMI in a kernel module
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:05 AM +0100 2002-07-27, Alan Cox wrote:
>I've been tracking other lists. The current state is very much that we
>need the dual notifier. I now have some draft code that allows us to do
>this even on hardware that doesn't support it, and where the read()
>function gets told when an event is about to occur

I'd be grateful for a copy of the draft code. We've done a machine 
with a hardware-based two-stage watchdog, and are in the process of 
implementing one on a more-vanilla piece of hardware.
-- 
/Jonathan Lundell.
