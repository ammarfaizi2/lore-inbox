Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVF0UeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVF0UeZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVF0Ua0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:30:26 -0400
Received: from smtp-2.llnl.gov ([128.115.250.82]:58071 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S261703AbVF0U2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:28:45 -0400
Date: Mon, 27 Jun 2005 13:28:43 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-reply-to: <1119902991.4794.5.camel@dhcp153.mvista.com>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.63.0506271327040.5120@ghostwheel.llnl.gov>
Organization: Lawrence Livermore National Laboratory
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Pine/4.62 (X11; U; Linux i686; en-US; rv:2.6.11-rc2-mm1)
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu>
 <200506250919.52640.gene.heskett@verizon.net>
 <200506251039.14746.gene.heskett@verizon.net>
 <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov>
 <1119902991.4794.5.camel@dhcp153.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2005, Daniel Walker wrote:

> If you have PREEMPT_RT enabled, it looks like interrupts are hard
> disabled then there is a schedule_timeout() requested. You could try
> turning off power management and see if you still have problems.
>
> Daniel
>

Well, putting apm=off in the kernel command line did the trick. I am
using a desktop system so apm really isn't needed. Time to change my
standard config file..... Thanks.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate         ICCD            Fax: 925-423-6961
Lawrence Livermore National Laboratory      Computation Directorate
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
------------------ http://tinyurl.com/5w5ey -----------------------
-- Useless Invention: Rollerblade skates for peglegs. --
