Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbWF3VRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbWF3VRO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbWF3VRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:17:14 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42436 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932609AbWF3VRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:17:12 -0400
Message-ID: <44A594D5.4040906@garzik.org>
Date: Fri, 30 Jun 2006 17:17:09 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Alexis Bruemmer <alexisb@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] aic94xx: disable split completion timer/setting by default
References: <1151701856.16075.59.camel@localhost.localdomain>
In-Reply-To: <1151701856.16075.59.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexis Bruemmer wrote:
> The aic94xx driver will lock up under heavy load with a split completion
> error.  There is a split completion timer/setting which should be
> disabled by default but is not.  This patch fixes this problem.
> 
> Signed-off-by: Adaptec
> Acked-by: Alexis Bruemmer <alexisb@us.ibm.com>

There are various aic94xx driver bits floating about, and I'm worried 
that it will stay forever outside the kernel.org tree.

Can you (a) make sure to CC linux-scsi@vger.kernel.org on all aic94xx 
patches, and (b) work with James Bottomley and the crew to get it 
working with the upstream tree?

	Jeff



