Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262887AbVF3IoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbVF3IoW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVF3IoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:44:21 -0400
Received: from spieleck.de ([217.197.84.238]:11026 "EHLO spieleck.de")
	by vger.kernel.org with ESMTP id S262887AbVF3IoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:44:19 -0400
Date: Thu, 30 Jun 2005 10:44:26 +0200
From: Stefan Seyfried <seife@gmane0305.slipkontur.de>
To: Fedor Karpelevitch <fedor@karpelevitch.net>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: AE_NO_MEMORY on ACPI init after memory upgrade and oops
Message-ID: <20050630084426.GA30436@message-id.gmane0305.slipkontur.de>
References: <200506300042.22255.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506300042.22255.fedor@karpelevitch.net>
X-Operating-System: SuSE Linux 9.3 (i586), Kernel 2.6.11.4-21.7-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:42:19AM -0700, Fedor Karpelevitch wrote:
> I tried to upgrade memory on my laptop from 2 x 128m by replacing one of the chips 
> with a 256m chip (these are PC2100 SODIMMS in case that matters). The new chip 
> appears to be fine - I do not see any memory corruptions or whatnot and I ran 
> memtest without any problems.
> 
> However there are two issues related to ACPI with this new chip (the problems
> go away when I replace it with the old one):
> 
> 1) when booting I get these error when "ec" module is being loaded:
> 
> Jun 23 23:25:28 bologoe kernel: [4294720.883000]     ACPI-0405: *** Error: Handler for [SystemMemory] returned AE_NO_MEMORY

Did you override your DSDT?
-- 
Stefan Seyfried
