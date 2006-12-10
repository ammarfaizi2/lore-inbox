Return-Path: <linux-kernel-owner+w=401wt.eu-S1760663AbWLJLNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760663AbWLJLNH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760670AbWLJLNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 06:13:07 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:43693 "EHLO
	alpha.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760663AbWLJLNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 06:13:04 -0500
Date: Sun, 10 Dec 2006 12:12:54 +0100
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 does not boot, while 2.6.19-rc4 does
Message-ID: <20061210111254.GI2706@gamma.logic.tuwien.ac.at>
References: <20061209152859.GA14037@gamma.logic.tuwien.ac.at> <20061209103954.868f818a.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061209103954.868f818a.randy.dunlap@oracle.com>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, hi all!

On Sam, 09 Dez 2006, Randy Dunlap wrote:
> > I copied my old config-2.6.19-rc4 to a clean linux-2.6.19 tree, called
> > make oldconfig; make, installed the kernel and modules, but the kernel
> > cannot find the root file system.

Strange enough, another day another run, it worked. I booted 2 times
with
	acpi=off
which worked, and then I recompiled a kernel (with ieee80211 built in)
and suddenly everything worked, even if I boot without the acpi=off
hack.

Sorry for the noise.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining <preining@logic.at>                    Università di Siena
Debian Developer <preining@debian.org>                         Debian TeX Group
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
Out of memory.
We wish to hold the whole sky,
But we never will.
                       --- Windows Error Haiku
