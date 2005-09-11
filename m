Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVIKJkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVIKJkQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 05:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbVIKJkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 05:40:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:18096 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964842AbVIKJkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 05:40:13 -0400
Date: Sun, 11 Sep 2005 10:40:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@redhat.com>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
Message-ID: <20050911094007.GB5429@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@redhat.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com> <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com> <1126383605.30449.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126383605.30449.12.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2005 at 09:20:05PM +0100, Alan Cox wrote:
> On Sad, 2005-09-10 at 10:30 -0400, Rik van Riel wrote:
> > That's very nice for you - but lets face it, a SAS layer
> > that'll be unable to also deal with the El-Cheapo brand
> > controllers isn't going to be very useful.
> 
> If future cheap SAS controllers are like cheap anything else controllers
> then it is better IMHO to deal with it once the problems are visible. We
> *know* from experience that hardware limits will be weirder than the
> anticipated.

Yes, absolutely.  This discussion is driving far off right now, no one
is asking Adaptec to add support for competing products here, we're just
asking to not declare the host_template in the common code, and supporting
limited controllers is one of the reasons.

