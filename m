Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264227AbTEPFlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTEPFlR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:41:17 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:52228 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S264227AbTEPFlQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:41:16 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200305160554.h4G5s8Es010863@green.mif.pg.gda.pl>
Subject: Re: The kernel is miscalculating my RAM...
To: techstuff@gmx.net
Date: Fri, 16 May 2003 07:54:08 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <200305160551.h4G5pbYO026350@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at May 16, 2003 07:51:47 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> ok here is what dmesg shows:
> 384MB LOWMEM available.
> 
> then further down:
> Memory: 385584k/393216k available (2010k kernel code, 7244k reserved, 597k 
> data, 128k init, 0k highmem)
        ^^^^

> now how is the little 38.../39... possible? 
> 
> and then top shows this:
> Mem:    385712k total

385584+128=385712

> this again is different than the others...
> 
> and finaly gkrellm is telling me that I have only 377 mb actually recognized 
> out of the 384mb that the kernel detected above...

# echo $((385712/1024))
376
 
> So the question is where does my 7mb go, why that weird 38.../39 difference 
> and why does top report another different value.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Gdansk University of Technology
