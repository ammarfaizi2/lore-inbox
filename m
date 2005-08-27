Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVH0J0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVH0J0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 05:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVH0J0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 05:26:50 -0400
Received: from lucidpixels.com ([66.45.37.187]:8393 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030344AbVH0J0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 05:26:49 -0400
Date: Sat, 27 Aug 2005 05:26:47 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.13-rc7 Latency Question
Message-ID: <Pine.LNX.4.63.0508270524340.14692@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These options are self-explanatory:

      x x          ( ) No Forced Preemption (Server)                     x 
x    x x          ( ) Voluntary Kernel Preemption (Desktop)             x 
x    x x          (X) Preemptible Kernel (Low-Latency Desktop)          x x



It says 100 HZ or 250 HZ is good for SMP systems; however, what if I am 
using a P4 machine with 1 CPU (HT), is 1000HZ still the way to go, as its 
not really 2 *REAL* cpus?

lqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqk x
        x x                          ( ) 100 HZ 
x      x x                          ( ) 250 HZ 
x      x x                          (X) 1000 HZ
