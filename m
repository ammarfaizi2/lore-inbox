Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVLNJHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVLNJHt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 04:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVLNJHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 04:07:48 -0500
Received: from mini.brewt.org ([216.18.5.212]:64785 "HELO mini.brewt.org")
	by vger.kernel.org with SMTP id S932216AbVLNJHr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 04:07:47 -0500
Date: Wed, 14 Dec 2005 01:07:47 -0800
From: "Adrian Yee" <brewt-linux-kernel@brewt.org>
Subject: Re: tsc clock issues with dual core and question about irq	balancing
To: john stultz <johnstul@us.ibm.com>
Cc: Adrian Yee <brewt-linux-kernel@brewt.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <GMail.1134551267.12292355.45625751005@brewt.org>
In-Reply-To: <1134522289.3897.21.camel@leatherman>
Mime-Version: 1.0
References: <GMail.1134458797.49013860.4106109506@brewt.org>
 <1134522289.3897.21.camel@leatherman>
X-Gmail-Account: brewt@brewt.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

>> I'm currently testing the system with "nosmp noapic acpi=off
>> clock=tsc" (it was losing interrupts and wouldn't boot properly
>> with apic/acpi on) and so far everything seems to work (this
>> includes ssh and desktop usage is better).
> 
> So keeping the above settings, does removing just the "clock=tsc"
> cause the sluggishness to appear?

I just tried booting with the pmtmr enabled and incoming ssh is bad
(I had an ls pause for over 20 seconds, while another connection was
somewhat fine).  I wish I had more concrete tests since the problems
I'm seeing are so subjective.  I guess I'll have to ignore this
problem until I get a better test.
 
> Also would you open a bugzilla bug on this and attach your .config
> and dmesg?

Done: http://bugzilla.kernel.org/show_bug.cgi?id=5740

Thanks.

Adrian
