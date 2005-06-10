Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVFJUp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVFJUp3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVFJUp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:45:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20703 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261225AbVFJUpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:45:19 -0400
Subject: Re: DMA mapping (was Re: [PATCH] cciss 2.6; replaces DMA masks
	with kernel defines)
From: Arjan van de Ven <arjan@infradead.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, mike.miller@hp.com, akpm@osdl.org,
       axboe@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <1118436000.6423.42.camel@mindpipe>
References: <20050610143453.GA26476@beardog.cca.cpqcorp.net>
	 <42A9C60E.3080604@pobox.com>  <1118436000.6423.42.camel@mindpipe>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 22:45:06 +0200
Message-Id: <1118436306.5272.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 16:39 -0400, Lee Revell wrote:
> On Fri, 2005-06-10 at 12:55 -0400, Jeff Garzik wrote:
> > mike.miller@hp.com wrote:
> > > This patch removes our homegrown DMA masks and uses the ones defined in
> > > the kernel instead.
> > > Thanks to Jens Axboe for the code. Please consider this for inclusion.
> > > 
> > > Signed-off-by: Mike Miller <mike.miller@hp.com>
> > 
> > You need to add '#include <linux/dma-mapping.h>'
> > 
> 
> Why doesn't this file define 29, 30, 31 bit DMA masks, required by many
> devices?  I know of at least 2 soundcards that need a 29 bit DMA mask.

your mail unfortunately was not in diff -u form ;)
I'm pretty sure that such constants are welcome


