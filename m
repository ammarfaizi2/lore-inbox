Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUG1Who@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUG1Who (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUG1WhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:37:19 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:44745 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S266683AbUG1WeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:34:16 -0400
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
Message-Id: <1091053646.8867.21.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 29 Jul 2004 08:27:26 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

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

Hmm. I'll take a look. Those patches are straight out of current
suspend2 and have been in there for some time. Perhaps I just don't have
any users who have that config.

Regards,

Nigel

