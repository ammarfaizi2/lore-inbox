Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVFGB56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVFGB56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVFGB56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 21:57:58 -0400
Received: from stark.xeocode.com ([216.58.44.227]:19073 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261205AbVFGB5y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 21:57:54 -0400
To: Mark Lord <liml@rtr.ca>
Cc: Greg Stark <gsstark@mit.edu>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [SATA] libata-dev queue updated
References: <42A14541.6020209@pobox.com> <87vf4ujgmj.fsf@stark.xeocode.com>
	<42A47376.80203@rtr.ca>
In-Reply-To: <42A47376.80203@rtr.ca>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 06 Jun 2005 21:57:32 -0400
Message-ID: <87u0kbhqsz.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord <liml@rtr.ca> writes:

> Greg Stark wrote:
> >
> > Are there diffs downloadable for these? In particular I'm looking for
> > passthru. I'm imagining that with passthru SMART works?
> 
> SMART works already using the HDIO_* ioctls in libata-dev
> (these may be built on top of the passthru stuff.. dunno).
> 
> Eg.  smartctl -data -a /dev/sda

Uh, this is 2.6.12-rc4 with the latest libata-dev patch from Garzik's web
site:

 bash-3.00$ smartctl -data -a /dev/sda
 smartctl version 5.32 Copyright (C) 2002-4 Bruce Allen
 Home page is http://smartmontools.sourceforge.net/

 Smartctl: Device Read Identity Failed (not an ATA/ATAPI device)

 A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.


-- 
greg

