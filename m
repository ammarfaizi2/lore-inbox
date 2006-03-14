Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751705AbWCNRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbWCNRnt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbWCNRns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 12:43:48 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:17325 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751696AbWCNRns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 12:43:48 -0500
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Greg KH <gregkh@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, "Moore, Eric" <Eric.Moore@lsil.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
In-Reply-To: <20060314172933.GA24619@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36D829@NAMAIL2.ad.lsil.com>
	 <20060314153455.GA8071@suse.de> <20060314170855.GA18342@infradead.org>
	 <20060314171951.GA22678@suse.de> <20060314172543.GA20331@infradead.org>
	 <20060314172933.GA24619@suse.de>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:43:30 -0600
Message-Id: <1142358210.3241.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 09:29 -0800, Greg KH wrote:
> Ah, ok, that makes more sense.
> 
> Eric, care to resend without the mime crud so I can apply it?

Actually, would it be OK if you sign off on this and I take it via the
scsi tree?  Otherwise there'll be a nasty cross dependency between
scsi-misc and usb and I'll spend the next week explaining what trees you
need to pull in to get scsi-misc to build.

Thanks,

James


