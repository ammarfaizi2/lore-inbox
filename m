Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750743AbWGFSRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGFSRo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 14:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGFSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 14:17:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2732 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750743AbWGFSRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 14:17:43 -0400
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch
	added to -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Doug Thompson <norsk5@yahoo.com>, akpm@osdl.org,
       mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060706180826.GA95795@muc.de>
References: <20060704092358.GA13805@muc.de>
	 <1152007787.28597.20.camel@localhost.localdomain>
	 <20060704113441.GA26023@muc.de>
	 <1152137302.6533.28.camel@localhost.localdomain>
	 <20060705220425.GB83806@muc.de> <m1odw32rep.fsf@ebiederm.dsl.xmission.com>
	 <20060706130153.GA66955@muc.de> <m18xn621i6.fsf@ebiederm.dsl.xmission.com>
	 <20060706165159.GB66955@muc.de> <m18xn6zkx3.fsf@ebiederm.dsl.xmission.com>
	 <20060706180826.GA95795@muc.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jul 2006 19:34:58 +0100
Message-Id: <1152210898.13734.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-07-06 am 20:08 +0200, ysgrifennodd Andi Kleen:
> > No. There is a status report that tells you which pieces of hardware
> > your memory controller sees.  It is just a simple list.
> 
> Ok but that could be also done easily in user space that reads
> PCI config space. No need for a complicated kernel driver at all.

The same is true of writing a file system and disk driver so I'm a bit
confused why you think poking around in PCI space from user space is an
argument or given how often such stuff breaks and how messy it gets (eg
X) that we want to encourage it


