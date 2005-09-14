Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932707AbVINKhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbVINKhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVINKhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:37:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14481 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932707AbVINKhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:37:22 -0400
Date: Wed, 14 Sep 2005 11:37:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Panov <sipan@sipan.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
Message-ID: <20050914103712.GA30503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sergey Panov <sipan@sipan.org>, Matthew Wilcox <matthew@wil.cx>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org> <4325FA6F.3060102@adaptec.com> <20050913154014.GE32395@parisc-linux.org> <1126677387.26050.71.camel@sipan.sipan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126677387.26050.71.camel@sipan.sipan.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 01:56:27AM -0400, Sergey Panov wrote:
> > As you know, stuff is being rearranged to move more of the SPI-specific
> > code from both SCSI core and LLDDs into the SPI transport.  I suspect
> > domain discovery will always be triggered by the LLDD for SPI, but at
> > least a driver doesn't have to have its own code to do that any more.
> 
> Only if it can be turned into a some sort of library LLDD may use if it
> needs it. But it is only makes sense to move that code out of the LLDD
> and into the transport module, if more then one LLDD can make use of it.

Umm, that's exactly what we are doing.

