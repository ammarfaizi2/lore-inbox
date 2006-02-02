Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423438AbWBBKNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423438AbWBBKNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423436AbWBBKNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:13:53 -0500
Received: from ns1.suse.de ([195.135.220.2]:63375 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423386AbWBBKNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:13:52 -0500
From: Andreas Schwab <schwab@suse.de>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Grant Grundler <iod00d@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/12] generic *_bit()
References: <20060201193933.GA16471@esmail.cup.hp.com>
	<200602012141.k11LfCg32497@unix-os.sc.intel.com>
	<20060201220903.GE16471@esmail.cup.hp.com>
	<Pine.LNX.4.64.0602012246330.3680@hermes-2.csi.cam.ac.uk>
	<20060202000820.GI16471@esmail.cup.hp.com>
	<Pine.LNX.4.64.0602020849160.785@hermes-2.csi.cam.ac.uk>
X-Yow: Now my EMOTIONAL RESOURCES are heavily committed to 23% of the
 SMELTING and REFINING industry of the state of NEVADA!!
Date: Thu, 02 Feb 2006 11:13:37 +0100
In-Reply-To: <Pine.LNX.4.64.0602020849160.785@hermes-2.csi.cam.ac.uk> (Anton
	Altaparmakov's message of "Thu, 2 Feb 2006 08:52:11 +0000 (GMT)")
Message-ID: <jemzhajcfi.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> writes:

> The name seems a bit silly as I imagine most fs drivers would be able to 
> use them and there already are ext2 and minix versions.  Probably ought 
> be renamed to a more generic name like le_test_bit() or something...

Minix is even more complicated, since the on-disk format is different
between architectures (the m68k port of Minix did not handle that
correctly).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
