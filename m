Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVKOAEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVKOAEt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKOAEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:04:49 -0500
Received: from ozlabs.org ([203.10.76.45]:2189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932254AbVKOAEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:04:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.9731.963322.721596@cargo.ozlabs.ibm.com>
Date: Tue, 15 Nov 2005 11:04:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com, ak@muc.de,
       benh@kernel.crashing.org, stephane.eranian@hp.com, tony.luck@intel.com
Subject: Re: + perfmon2-reserve-system-calls.patch added to -mm tree
In-Reply-To: <200511150050.27556.arnd@arndb.de>
References: <200511142329.jAENTfmS004600@shell0.pdx.osdl.net>
	<200511150050.27556.arnd@arndb.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> Hmm, I had sent an earlier patch to paulus that reserves 278 and
> 279 for spu_run and spu_create and that apparently got dropped.

Hmmm, sorry, I thought I had put that in, but evidently not.

> Could I have those two numbers or is there already an established
> user based for the perfmon2 numbers that would take preference?

I don't believe there is any user base of the perfmon2 numbers.
Stephane, could you respin using 280 - 291 for PowerPC?

Thanks,
Paul.
