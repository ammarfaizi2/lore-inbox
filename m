Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRJKCr3>; Wed, 10 Oct 2001 22:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277945AbRJKCrU>; Wed, 10 Oct 2001 22:47:20 -0400
Received: from cs.columbia.edu ([128.59.16.20]:48870 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S277918AbRJKCrA>;
	Wed, 10 Oct 2001 22:47:00 -0400
Date: Wed, 10 Oct 2001 22:47:29 -0400
Message-Id: <200110110247.f9B2lTc03454@moisil.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: elf@florence.buici.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 selftest failure in 2.4.11 (and .10)
In-Reply-To: <20011010095012.A29307@buici.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac7 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 09:50:12 -0700, elf@florence.buici.com wrote:

> When the 2.2.17 kernel boots, it reports that
> 
>  The receiver lock-up bug exists -- enabling workaround.

That was a bug in the 2.2.17 kernel, fixed in 2.2.19. The
message was bogus.

As for your 2.4 problem, from the driver messages it's pretty
clear that it can't talk at all to the chipset. I'm not sure
what the problem is, but I seriously doubt it's a driver issue.
The PCI code is a much more likely suspect.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
