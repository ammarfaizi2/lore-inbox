Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287497AbSAEEBV>; Fri, 4 Jan 2002 23:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287498AbSAEEBM>; Fri, 4 Jan 2002 23:01:12 -0500
Received: from frank.gwc.org.uk ([212.240.16.7]:22024 "EHLO frank.gwc.org.uk")
	by vger.kernel.org with ESMTP id <S287497AbSAEEA6>;
	Fri, 4 Jan 2002 23:00:58 -0500
Date: Sat, 5 Jan 2002 04:00:57 +0000 (GMT)
From: Alistair Riddell <ali@gwc.org.uk>
To: linux-kernel@vger.kernel.org
Subject: no highmem with 2GB RAM?
Message-ID: <Pine.LNX.4.21.0201050126410.12917-100000@frank.gwc.org.uk>
X-foo: bar
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple of SMP i386 boxes with 2GB RAM. They suffer from poor
performance due to block IO page bouncing with highmem enabled. I have
tried the block-highmem patch but this causes occasional oopses and even
panics under high IO load.

Will there be any ill effects if I change __PAGE_OFFSET to 0x7000000 or
thereabouts so that all RAM is mapped? 

I presume I only have to change this is page.h and vmlinux.lds.S as in 2.2
kernels.

-- 
Alistair Riddell - BOFH
IT Manager, George Watson's College, Edinburgh
Tel: +44 131 446 6070    Fax: +44 131 452 8594
Microsoft - because god hates us


