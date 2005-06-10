Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVFJQ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVFJQ4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 12:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVFJQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 12:56:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:47579 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262605AbVFJQ4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 12:56:01 -0400
Message-ID: <42A9C60E.3080604@pobox.com>
Date: Fri, 10 Jun 2005 12:55:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike.miller@hp.com
CC: akpm@osdl.org, axboe@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] cciss 2.6; replaces DMA masks with kernel defines
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
In-Reply-To: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike.miller@hp.com wrote:
> This patch removes our homegrown DMA masks and uses the ones defined in
> the kernel instead.
> Thanks to Jens Axboe for the code. Please consider this for inclusion.
> 
> Signed-off-by: Mike Miller <mike.miller@hp.com>

You need to add '#include <linux/dma-mapping.h>'

	Jeff



