Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWDNPgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWDNPgz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 11:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDNPgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 11:36:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750770AbWDNPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 11:36:54 -0400
Subject: Re: Where to call L2 cache enabling code from?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Steve Snyder <swsnyder@insightbb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200604141105.43216.swsnyder@insightbb.com>
References: <200604141105.43216.swsnyder@insightbb.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 16:46:14 +0100
Message-Id: <1145029574.17531.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-04-14 at 11:05 -0400, Steve Snyder wrote:
> I have a machine in which the BIOS does not enable the Pentium3's L2 cache 
> at boot time.  At what point in the kernel init process can/should I call 
> the code to enable the cache?

What part of the cache setup is not done correctly ? The mtrr registers
or other things ?

