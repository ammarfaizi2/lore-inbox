Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVA1BuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVA1BuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVA1BuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:50:00 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:21946 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261379AbVA1Bt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:49:56 -0500
Subject: Re: crypto algoritms failing?
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Jasper Spaans <jasper@vs19.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ajgrothe@yahoo.com
In-Reply-To: <20050127233007.GA4678@spaans.vs19.net>
References: <20050127233007.GA4678@spaans.vs19.net>
Content-Type: text/plain
Message-Id: <1106876975.15806.42.camel@nigelcunningham>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 28 Jan 2005 12:49:35 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

You normally test cryptoapi functionality while booting?

Anyway, I can confirm that if suspend2 touches anything remotely related
to this, it's unintentional and I'll fix it :>

Nigel

On Fri, 2005-01-28 at 10:30, Jasper Spaans wrote:
> Hi List,
> 
> When booting I see this in dmesg:
> 
> testing tea ECB encryption 
> test 1 (128 bit key):
> 0a3aea4140a9ba94
> fail
> test 2 (128 bit key):
> 775d2a6af6ce9209
> fail
> test 3 (128 bit key):
> be7abb81952d1f1edd89a1250421df95
> fail
> test 4 (128 bit key):
> e04d5d3cb78c364794189591a9fc49f844d12dc299b8082a078973c24592c690
> fail
> [..]
> testing xtea ECB encryption 
> test 1 (128 bit key):
> aa2296e56c61f345
> fail
> test 2 (128 bit key):
> 823eeb35dcddd9c3
> fail
> test 3 (128 bit key):
> e204dbf289859eea6135aaedb5cb712c
> fail
> test 4 (128 bit key):
> 0b03cd8abe95fdb1c144910ba5c91bb4a9da1e9eb13e2a8feaa56a85d1f4a8a5
> fail
> 
> CPU in that machine is an athlon xp, cpu flags according to /proc/cpuinfo
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
> 
> Compiler: gcc 3.3.5 (debian package 1:3.3.5-6)
> 
> Is this supposed to happen?
> 
> 
> Jasper
-- 
Nigel Cunningham
Software Engineer
Cyclades Corporation

http://cyclades.com

