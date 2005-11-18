Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbVKRS4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbVKRS4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161121AbVKRS4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:56:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:1475 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161119AbVKRS4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:56:14 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43797E05.5090107@wolfmountaingroup.com>
References: <58MJb-2Sn-37@gated-at.bofh.it> <58NvO-46M-23@gated-at.bofh.it>
	 <58Rpx-1m6-11@gated-at.bofh.it> <58UGF-6qR-27@gated-at.bofh.it>
	 <58UQf-6Da-3@gated-at.bofh.it> <437933B6.1000503@shaw.ca>
	 <1132020468.27215.25.camel@mindpipe> <20051115032819.GA5620@redhat.com>
	 <43795575.9010904@wolfmountaingroup.com>
	 <20051115050658.GA13660@redhat.com>
	 <43797E05.5090107@wolfmountaingroup.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Nov 2005 19:27:45 +0000
Message-Id: <1132342065.25914.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 23:19 -0700, Jeff V. Merkey wrote:
> Making the point that in 1990, folks had grown beyond 4K stacks in 
> kernels, along with MS DOS 640K Limitations.

And Linux 8086 uses 512 byte kernel stacks, and really wants a bit of
tuning to get down to 256.

Its about discipline and design not year

