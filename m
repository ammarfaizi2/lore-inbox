Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269162AbUI2WiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269162AbUI2WiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269116AbUI2WiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:38:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269162AbUI2Wgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:36:49 -0400
Date: Wed, 29 Sep 2004 17:35:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, mikem@beardog.cca.cpqcorp.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       "Baker, Brian (ISS - Houston)" <brian.b@hp.com>
Subject: Re: patch so cciss stats are collected in /proc/stat
Message-ID: <20040929203548.GA19037@logos.cnet>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DBFE0B@cceexc23.americas.cpqcorp.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 11:29:59AM -0500, Miller, Mike (OS Dev) wrote:
> 
> > On Wed, Sep 29, 2004 at 11:13:45AM -0500, mike.miller@hp.com wrote:
> > > Currently cciss statistics are not collected in /proc/stat. 
> > This patch
> > > bumps DK_MAX_MAJOR to 111 to fix that. This has been a 
> > common complaint
> > > by customers wishing to gather info about cciss devices.
> > > Please consider this for inclusion. Applies to 2.4.28-pre3.
> > 
> > This patch has been reject about half a million times, why are people
> > submitting it again and again?
> 
> As I said in my mail, it's a customer driven issue. As long as customers rely on /proc/stat we'll keep trying. You can't tell a customer how he/she should be doing things on their systems.

Mike, 

I dont like the patch either.

If you can have the same statistics through /proc/partitions 
(do I get this right?) just tell that to users.

