Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266397AbUG1XIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266397AbUG1XIi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUG1Wwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:52:38 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:33231 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267320AbUG1Wn1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:43:27 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040728142026.79860177.akpm@osdl.org>
	 <1091053822.1844.4.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Message-Id: <1091054194.8867.26.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 08:36:34 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Thu, 2004-07-29 at 08:30, Felipe Alfaro Solana wrote:
> On Wed, 2004-07-28 at 14:20 -0700, Andrew Morton wrote:
> 
> > wrt your "Add missing refrigerator support" patch: I'll suck that up, but
> > be aware that there's a big i2o patch in -mm which basically rips out the
> > driver which you just fixed up.  Perhaps you can send Markus Lidel
> > <Markus.Lidel@shadowconnect.com> and I a fix for that version of the driver
> > sometime?
> 
> BTW, the "Add missing refrigerator support" breaks ACPI S3 and S4
> support for me (2.6.8-rc2-bk7) and my laptop (NEC Chrom@). When
> resuming, my 3c59x CardBus NIC is not powered up forcing me to eject it,
> then plug it again.

Looking again at the patch, I'm not sure which diff would be relevant to
you. When the card is running, do you have a kIrDAd thread?

Regards,

Nigel

