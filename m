Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUG1Wcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUG1Wcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266486AbUG1Wbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:31:34 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24324 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266603AbUG1Wai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:30:38 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ncunningham@linuxmail.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040728142026.79860177.akpm@osdl.org>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 29 Jul 2004 00:30:22 +0200
Message-Id: <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 14:20 -0700, Andrew Morton wrote:

> wrt your "Add missing refrigerator support" patch: I'll suck that up, but
> be aware that there's a big i2o patch in -mm which basically rips out the
> driver which you just fixed up.  Perhaps you can send Markus Lidel
> <Markus.Lidel@shadowconnect.com> and I a fix for that version of the driver
> sometime?

BTW, the "Add missing refrigerator support" breaks ACPI S3 and S4
support for me (2.6.8-rc2-bk7) and my laptop (NEC Chrom@). When
resuming, my 3c59x CardBus NIC is not powered up forcing me to eject it,
then plug it again.

