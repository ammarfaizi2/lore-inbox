Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUJGVVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUJGVVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268406AbUJGVTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:19:54 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:21738 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268257AbUJGVAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:00:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm3: build problem on dual-Opteron w/ NUMA
Date: Thu, 7 Oct 2004 23:01:39 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20041007015139.6f5b833b.akpm@osdl.org>
In-Reply-To: <20041007015139.6f5b833b.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410072301.39399.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 of October 2004 10:51, Andrew Morton
> 
> 
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm3/

It does not build on a dual-Opteron box w/ NUMA:

  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/x86_64/kernel/built-in.o(.init.text+0x1fc1): In function 
`late_hpet_init':
: undefined reference to `hpet_alloc'
make: *** [.tmp_vmlinux1] Error 1

The .config is available at:
http://www.sisk.pl/kernel/041007/2.6.9-rc3-mm3-NUMA.config

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
