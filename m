Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269475AbUINSPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269475AbUINSPq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269521AbUINSOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:14:02 -0400
Received: from [69.28.190.101] ([69.28.190.101]:38622 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269475AbUINSHM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:07:12 -0400
Date: Tue, 14 Sep 2004 14:07:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
Message-ID: <20040914180708.GA20544@havoc.gtf.org>
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <41472FA0.2090108@rtr.ca> <414730D9.3000003@pobox.com> <41473270.3070405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41473270.3070405@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:03:28PM -0400, Mark Lord wrote:
> Whatever this driver does, it has to be reasonably portable
> back to early 2.4.xx kernels, so it cannot depend too much
> upon newly (or to-be) implemented semantics in 2.6.xx.

Feel free to examine libata's use of ->eh_strategy_handler
in 2.4.x ;-)

	Jeff



