Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268794AbTGOQBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 12:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268789AbTGOQAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 12:00:11 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:41149
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S268577AbTGOP7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:59:32 -0400
Date: Tue, 15 Jul 2003 12:14:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jeff Mock <jeff-ml@mock.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI ATA driver in 2.4.22 ?
Message-ID: <20030715161418.GE13207@gtf.org>
References: <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <PMEMILJKPKGMMELCJCIGOEKNCCAA.kfrazier@mdc-dayton.com> <5.1.0.14.2.20030715084326.077d0480@mail.mock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030715084326.077d0480@mail.mock.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 08:58:16AM -0700, Jeff Mock wrote:
> 
> Is Jeff Garzik's SCSI ATA driver going in 2.4.22?  I've been using it
> with great success with 2.4.21-ac4, but I haven't seen it in any
> of the 2.4.22-pre kernels.
> 
> If it's not going in, is there an alternative for accessing serial
> ATA devices in native/enhanced mode rather than legacy mode?

My preference would be to merge into 2.6.0-test first, then send it to
Marcelo after that.  Otherwise, people upgrading 2.4->2.6 would get
shafted.

Besides that, I certainly would not object to it being in 2.4.22.
(but I'm biased :))


> By the way, if you name your child libata, some say the name has
> some nice qualities:
> 
>    http://www.kabalarians.com/male/libata.htm

That rules ;-)

	Jeff



