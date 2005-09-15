Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVIOKjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVIOKjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 06:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVIOKjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 06:39:36 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:48635 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S932125AbVIOKjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 06:39:35 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk
X-X-Sender: dlang@dlang.diginsite.com
Date: Thu, 15 Sep 2005 03:39:21 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [PATCH 04/11] hpt366: write the full 4 bytes of ROM address,
 not just low 1 byte
In-Reply-To: <20050915061136.GZ7762@shell0.pdx.osdl.net>
Message-ID: <Pine.LNX.4.62.0509150335520.9384@qynat.qvtvafvgr.pbz>
References: <20050915010343.577985000@localhost.localdomain>
 <20050915010404.660502000@localhost.localdomain>
 <Pine.LNX.4.62.0509141917070.8469@qynat.qvtvafvgr.pbz>
 <20050915061136.GZ7762@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Chris Wright wrote:

> * David Lang (dlang@digitalinsight.com) wrote:
>> didn't Linus find similar bugs in a couple of the other hpt drivers as
>> well? if so can they be fixed at the same time?
>
> Yes, and they're in this series.  This patch does:
>
> drivers/ide/pci/hpt366.c
>
> And patch 10/11 does:
>
> drivers/ide/pci/cmd64x.c
> drivers/ide/pci/hpt34x.c
>
> Additionally, the sungem (5/11) and sunhme (6/11) changes are fallout
> from PCI_ROM fixes.
>
> I believe the remainder of the PCI_ROM related patches were primarily
> for consistency.

sorry about the noise, I read through all the descriptions looking for 
these, but I hadn't read all the patches.

David Lang

P.S. thanks to the kernel team for catching this before I got a chance to 
install .13 on my system that has a hpt374 controller :-)
-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
