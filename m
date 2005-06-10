Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFJUjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFJUjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVFJUjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:39:19 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61072 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261220AbVFJUjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:39:07 -0400
Subject: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks with
	kernel defines)
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mike.miller@hp.com, akpm@osdl.org, axboe@suse.de,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <42A9C60E.3080604@pobox.com>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
	 <42A9C60E.3080604@pobox.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:39:59 -0400
Message-Id: <1118436000.6423.42.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 12:55 -0400, Jeff Garzik wrote:
> mike.miller@hp.com wrote:
> > This patch removes our homegrown DMA masks and uses the ones defined in
> > the kernel instead.
> > Thanks to Jens Axboe for the code. Please consider this for inclusion.
> > 
> > Signed-off-by: Mike Miller <mike.miller@hp.com>
> 
> You need to add '#include <linux/dma-mapping.h>'
> 

Why doesn't this file define 29, 30, 31 bit DMA masks, required by many
devices?  I know of at least 2 soundcards that need a 29 bit DMA mask.

Lee

