Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWALFrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWALFrn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 00:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWALFrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 00:47:42 -0500
Received: from ozlabs.org ([203.10.76.45]:30361 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964821AbWALFrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 00:47:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17349.60783.236661.875374@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jan 2006 16:47:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Mark Maule <maule@sgi.com>, Tony Luck <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/3] msi vector targeting abstractions
In-Reply-To: <20060112050243.GC332@colo.lackof.org>
References: <20060111155251.12460.71269.12163@attica.americas.sgi.com>
	<20060111155256.12460.26048.32596@attica.americas.sgi.com>
	<20060112050243.GC332@colo.lackof.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler writes:

> > +	if ((status = msi_arch_init()) < 0) {
> 
> Willy told me I should always complain about assignment in if() statements :)

We are getting incredibly politically correct these days, aren't we.

I see nothing wrong with that if statement.  It's perfectly valid,
idiomatic C.  You can ignore Willy if you like. :)

(I would look askance at something that did an assignment as one of
the parameters of a procedure call in an if statement, though.)

Paul.
