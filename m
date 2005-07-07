Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVGGTIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVGGTIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbVGGTGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:06:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:15786 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261946AbVGGTEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:04:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Jon Schindler" <jonschindler@hotmail.com>
Subject: Re: Kernel Oops with dual core athlon 64 (quick question)
Date: Thu, 7 Jul 2005 21:04:25 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <BAY20-F42FDD187485A266D3988B6C4D80@phx.gbl> <200507071129.38714.rjw@sisk.pl> <BAY103-DAV217585FF946492DCAC9FFC4D80@phx.gbl>
In-Reply-To: <BAY103-DAV217585FF946492DCAC9FFC4D80@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507072104.26034.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 7 of July 2005 18:41, Jon Schindler wrote:
> Hi Rafael,
> I looked at the patch and noticed that it's changing a file inside 
> linux-2.6.12-rc6/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
> So, basically, it's modifying the powernow driver in the i386 arch 
> directory, but shouldn't that file be in "arch/x86_64/....", or am I missing 
> something?

Yes. :-)

> I'm compiling the kernel for x86_64, so will my 64 bit kernel  
> use this file even though it's in the i386 directory?

Yes, it will.  x86-64 uses some sources from i386 directly, including
cpufreq (they would be identical anyway).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
