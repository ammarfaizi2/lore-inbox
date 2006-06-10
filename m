Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWFJQuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWFJQuW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbWFJQuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:50:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49342 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751216AbWFJQuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:50:21 -0400
Message-ID: <448AF84A.6050107@garzik.org>
Date: Sat, 10 Jun 2006 12:50:18 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: James Bottomley <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
References: <20060610160852.GA15316@havoc.gtf.org> <20060610161036.GA21454@infradead.org> <1149956952.3335.22.camel@mulgrave.il.steeleye.com> <20060610163420.GA23699@infradead.org>
In-Reply-To: <20060610163420.GA23699@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> So removing the READ/WRITE6 emulation and setting the flag so the midlayer
> only uses READ/WRITE10+ is on top of the TODO list.  Right after that is

Done and checked into 'stex' branch at URL given.  I also removed 6-byte 
MODE SENSE.


> using the scsi_kmap_atomic_sg/scsi_kunmap_atomic_sg for the remaining
> emulated commands.  More comments later.

These functions don't appear to be in upstream yet.

	Jeff


