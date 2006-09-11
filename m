Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWIKW21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWIKW21 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbWIKW21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:28:27 -0400
Received: from hermes.domdv.de ([193.102.202.1]:56328 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S965082AbWIKW21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:28:27 -0400
Message-ID: <4505E304.7000302@domdv.de>
Date: Tue, 12 Sep 2006 00:28:20 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051004)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Pavel Machek <pavel@suse.cz>, Eric Sandall <eric@sandall.us>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to ram with 2.6 kernels
References: <44FF8586.8090800@sandall.us> <20060907193333.GI8793@ucw.cz> <450536D0.4020705@domdv.de> <200609112227.15572.rjw@sisk.pl>
In-Reply-To: <200609112227.15572.rjw@sisk.pl>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday, 11 September 2006 12:13, Andreas Steinmetz wrote:
> 
>>Pavel Machek wrote:
>>
>>>See suspend.sf.net, use provided s2ram program.
>>
>>Which,in my case (Acer Ferrari 4006), only works with "noapic" and
>>"radeon" not loaded.
>>Without "noapic" the system doesn't resume at all (same symptoms),
> 
> 
> Have you tried with ec_intr=0?
> 

Nope,
but the hint from this thread was good: s2ram works with
"acpi_skip_timer_override" and probably "enable_timer_pin_1" (I have to
try without this one, yet). Radeon, however, remains as a problem.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
