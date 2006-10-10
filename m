Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965140AbWJJJhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965140AbWJJJhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 05:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWJJJhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 05:37:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:4319 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965140AbWJJJhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 05:37:23 -0400
Date: Tue, 10 Oct 2006 10:36:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SCSI osst: add error handling to module init, sysfs
Message-ID: <20061010093648.GI395@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jeff@garzik.org>, linux-scsi@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061004092304.GA14685@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004092304.GA14685@havoc.gtf.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 05:23:04AM -0400, Jeff Garzik wrote:
> 
> - check all sysfs-related return codes, and propagate them back to callers
> 
> - properly unwind errors in osst_probe(), init_osst().  This fixes a
>   leak that occured if scsi driver registration failed, and fixes an
>   oops if sysfs creation returned an error.
> 
> (unrelated)
> - kzalloc() cleanup in new_tape_buf()
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>

Ok.

