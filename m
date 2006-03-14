Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWCNR5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWCNR5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWCNR5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:57:54 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:20192
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750726AbWCNR5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:57:53 -0500
Date: Tue, 14 Mar 2006 09:57:41 -0800
From: Greg KH <gregkh@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, "Moore, Eric" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
Message-ID: <20060314175741.GA2697@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com> <20060314153455.GA8071@suse.de> <20060314170855.GA18342@infradead.org> <20060314171951.GA22678@suse.de> <20060314172543.GA20331@infradead.org> <20060314172933.GA24619@suse.de> <1142358210.3241.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142358210.3241.28.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 11:43:30AM -0600, James Bottomley wrote:
> On Tue, 2006-03-14 at 09:29 -0800, Greg KH wrote:
> > Ah, ok, that makes more sense.
> > 
> > Eric, care to resend without the mime crud so I can apply it?
> 
> Actually, would it be OK if you sign off on this and I take it via the
> scsi tree?  Otherwise there'll be a nasty cross dependency between
> scsi-misc and usb and I'll spend the next week explaining what trees you
> need to pull in to get scsi-misc to build.

Sure, that makes a lot of sense:

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Oh, and please make that scsi wrapper function either
EXPORT_SYMBOL_GPL() or an inline function or macro.

thanks,

greg k-h
