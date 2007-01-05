Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbXAEU4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbXAEU4B (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 15:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbXAEU4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 15:56:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:59635 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbXAEU4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 15:56:00 -0500
Subject: Re: 2.6.20-rc3-mm1
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200701051723.08112.m.kozlowski@tuxland.pl>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	 <200701051723.08112.m.kozlowski@tuxland.pl>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 07:55:36 +1100
Message-Id: <1168030536.22458.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 17:23 +0100, Mariusz Kozlowski wrote:
> Hello, 
> 
> 	Doesn't build on my iMac G3 based garage jukebox ;-)
> 
> arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2
> 
> I guess someone who knows multithread code should take a look at it.

Hrm. struct driver -> multithread_probe is gone in -mm ?

Ben.


