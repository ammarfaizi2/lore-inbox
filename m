Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVDHNSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVDHNSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVDHNKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:10:54 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33960 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262820AbVDHNJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:09:20 -0400
Date: Fri, 8 Apr 2005 15:09:10 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050408130909.GS22988@suse.de>
References: <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave> <20050407064934.GJ15165@suse.de> <1112879919.5842.3.camel@mulgrave> <20050407132205.GA16517@infradead.org> <1112880658.5842.10.camel@mulgrave> <20050407133222.GJ1847@suse.de> <1112881183.5842.13.camel@mulgrave> <20050407144557.GK1847@suse.de> <1112965449.5838.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112965449.5838.9.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2005, James Bottomley wrote:
> On Thu, 2005-04-07 at 16:45 +0200, Jens Axboe wrote:
> > So clear ->request_queue instead.
> 
> 
> Will do.  Did you want me to look after your patch and add this, or do
> you want to send it to Linus (after the purdah is over)?

Just queue it with the rest of your changes, that is fine with me.

-- 
Jens Axboe

