Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTJ0Q7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 11:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbTJ0Q7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 11:59:22 -0500
Received: from havoc.gtf.org ([63.247.75.124]:44470 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263412AbTJ0Q7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 11:59:17 -0500
Date: Mon, 27 Oct 2003 11:59:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Shaun Savage <savages@savages.net>
Cc: linux-kernel@vger.kernel.org, edt@aei.ca, nuno.silva@vgertech.com
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
Message-ID: <20031027165916.GE19711@gtf.org>
References: <3F9D402F.9050509@savages.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9D402F.9050509@savages.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 07:56:31AM -0800, Shaun Savage wrote:
> 
> 
> >Are you using CONFIG_SCSI_SATA in 2.6?
> 
> No, but I am trying now.
> GREAT is works,
> but the disk went from hda back to hde

hmmm, with CONFIG_SCSI_SATA your SATA drives should show up as
 /dev/sda not /dev/hde ...

So, you're still using the drivers/ide driver, it appears.

Regardless, it's most important to use what works for you ;-)

	Jeff



