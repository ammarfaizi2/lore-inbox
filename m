Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751597AbWFJQaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbWFJQaI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWFJQaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:30:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10174 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751597AbWFJQaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:30:07 -0400
Message-ID: <448AF38C.5030208@garzik.org>
Date: Sat, 10 Jun 2006 12:30:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       promise_linux@promise.com
Subject: Re: [PATCH] Promise 'stex' driver
References: <20060610160852.GA15316@havoc.gtf.org> <20060610161036.GA21454@infradead.org>
In-Reply-To: <20060610161036.GA21454@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Jun 10, 2006 at 12:08:52PM -0400, Jeff Garzik wrote:
>> Please review, and queue in scsi-misc for 2.6.18 if acceptable.
> 
> The driver is not for scsi hardware.  Please implement it as block
> driver.

That's a new requirement.  The interface to the hardware is clearly SCSI.

	Jeff



