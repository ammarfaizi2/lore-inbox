Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWKJElx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWKJElx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945976AbWKJElx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:41:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1945972AbWKJElx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:41:53 -0500
Date: Thu, 9 Nov 2006 20:41:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
Message-Id: <20061109204145.56d02153.akpm@osdl.org>
In-Reply-To: <20061109100953.GE2226@stingr.net>
References: <20061109100953.GE2226@stingr.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Nov 2006 13:09:53 +0300
Paul P Komkoff Jr <i@stingr.net> wrote:

> Hi.
> 
> I have a couple of old SMP systems (Dual P3 on Intel STL2 boards), on
> which I experience the following:
> procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu------
>  0  0      0 800752  45376 143064    0    0     0     8 96607   65  0 0 100  0  0
>  0  0      0 800752  45376 143064    0    0     0     0 96439   57  0 0 100  0  0
> 
> It's a completely idle system. Interrupts are coming from rtc.
> This is a stock fedora SMP kernel.
> 
> IIRC, some time ago (years) I've read that rtc can be used somehow in
> SMP but I don't remember the specifics. So, maybe you are familiar
> with this and can give out a quick answer - what this 100K
> interrupts/sec are about, and how to get rid of them (if possible).
> 

I guess we could start with the full dmesg output and the kernel version?
