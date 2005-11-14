Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbVKNPT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVKNPT2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVKNPT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:19:28 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:15325 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751149AbVKNPT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:19:27 -0500
Message-ID: <4378AAF9.5090007@rtr.ca>
Date: Mon, 14 Nov 2005 10:19:21 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-rc1: kswapd crash
References: <4377D1B2.8070003@rtr.ca> <20051114004758.GA5735@stusta.de>	 <4377FFA7.4030400@rtr.ca> <20051114035616.GD5735@stusta.de>	 <43788F17.1080507@rtr.ca> <1131975465.2821.33.camel@laptopd505.fenrus.org>
In-Reply-To: <1131975465.2821.33.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>It's not.  VMware had never been run to that point.
>
> well the kernel modules are loaded...

Yes.  They are loaded at boot time, and sit mostly dormant
until the main app is run.

But really guys, I'm just reporting a datapoint with the new kernel,
pointing out that it crashed quite unexpectedly for no obvious reason.

Previous kernels have worked very well under the same conditions,
but this new one has had this one spot of trouble so far.

A datapoint.  Maybe it will happen again, maybe it won't happen again.
Maybe it won't happen again until it's installed on a critical
server at somewhere like VISA.  Or not.

Just a datapoint, and perhaps the VM folks will think about the traceback
some, and try to imagine any recent change that could have triggered it.

Cheers

