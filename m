Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266365AbUFQEll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266365AbUFQEll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 00:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266371AbUFQEll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 00:41:41 -0400
Received: from havoc.gtf.org ([216.162.42.101]:23017 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266365AbUFQEli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 00:41:38 -0400
Date: Thu, 17 Jun 2004 00:41:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       achew@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] current libata queue
Message-ID: <20040617044136.GA21553@havoc.gtf.org>
References: <20040617043321.GA20746@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617043321.GA20746@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 12:33:21AM -0400, Jeff Garzik wrote:
> 
> Here is my latest queue, including the nvidia changes and config
> changes.
> 
> Instead of two config options -- one in IDE and one in libata --
> I decided just to do one in IDE:
> 	"Support for SATA (deprecated; use libata)?"
> 
> Let me know if anyone feels I should still do a config option in libata.
> 
> Also, if this patch is too large for review, I would be glad to split
> them up and post them separately.


BTW, I'm in the middle of debugging the AHCI merge, so the patch just
posted won't go upstream until further changes land.

	Jeff



