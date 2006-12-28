Return-Path: <linux-kernel-owner+w=401wt.eu-S965016AbWL1W1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWL1W1j (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbWL1W1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:27:39 -0500
Received: from [139.30.44.16] ([139.30.44.16]:19222 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965016AbWL1W1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:27:39 -0500
Date: Thu, 28 Dec 2006 23:27:34 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Randy Dunlap <randy.dunlap@oracle.com>, Al Viro <viro@ftp.linux.org.uk>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 556 unneeded #includes of sched.h
In-Reply-To: <20061228222314.GG20596@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.63.0612282325120.12019@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.63.0612282059160.8356@gockel.physik3.uni-rostock.de>
 <20061228124644.4e1ed32b.akpm@osdl.org> <Pine.LNX.4.63.0612282154460.20531@gockel.physik3.uni-rostock.de>
 <20061228210803.GR17561@ftp.linux.org.uk>
 <Pine.LNX.4.63.0612282211330.20531@gockel.physik3.uni-rostock.de>
 <20061228213438.GD20596@flint.arm.linux.org.uk> <20061228133246.ad820c6a.randy.dunlap@oracle.com>
 <20061228214830.GF20596@flint.arm.linux.org.uk>
 <Pine.LNX.4.63.0612282251560.6944@gockel.physik3.uni-rostock.de>
 <20061228222314.GG20596@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, Russell King wrote:

> I'm talking about cross-builds...  I don't know the spec of the machine,
> only that it's x86 based (I don't run it.)
> 
> The last report at the beginning of this month said: 11 1/2 hours per
> git snapshot, which is apparantly for building a total of about 115
> kernels covering all ARM defconfigs, MIPS, PPC, and i386.

Ah, that sound reassuring: 115 kernels in 11.5 hours = 6 minutes per 
kernel.

I just started building all arm defconfigs, and assabet_defconfig took
about 7 minutes. So I don't seem to be that far off.

Thanks,
Tim
