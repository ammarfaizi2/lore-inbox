Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWAQQul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWAQQul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAQQul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:50:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:3798 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932168AbWAQQuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:50:40 -0500
Date: Tue, 17 Jan 2006 17:50:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jens Axboe <axboe@suse.de>
cc: Christoph Hellwig <hch@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       lkml <linux-kernel@vger.kernel.org>, jgarzik <jgarzik@pobox.com>,
       jejb <james.bottomley@steeleye.com>
Subject: Re: [PATCH/RFC] SATA in its own config menu
In-Reply-To: <20060116141203.GD3945@suse.de>
Message-ID: <Pine.LNX.4.61.0601171749170.18569@yvahk01.tjqt.qr>
References: <20060115135728.7b13996d.rdunlap@xenotime.net>
 <20060116121328.GA12871@infradead.org> <20060116141203.GD3945@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> we'll soon support (or already do?) support sata atapi, when this
>> won't be true anymore.  Please never select scsi upper drivers from
>> lower drivers, this independence is the whole point of the layered
>> architecture.

Hm, doesnot usb_storage select sd_mod? If I understand you correctly, this 
usb->sd selection is exactly the thing you don't want.



Jan Engelhardt
-- 
