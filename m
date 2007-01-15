Return-Path: <linux-kernel-owner+w=401wt.eu-S932335AbXAONnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXAONnB (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 08:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbXAONnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 08:43:01 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47477 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbXAONnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 08:43:01 -0500
Message-ID: <45AB84D8.3020507@garzik.org>
Date: Mon, 15 Jan 2007 08:42:48 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Robert Hancock <hancockr@shaw.ca>,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrin?= =?ISO-8859-1?Q?k?= 
	<B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <45AAE635.8090308@shaw.ca> <20070115025319.GC4516@kernel.dk>
In-Reply-To: <20070115025319.GC4516@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> I'd be surprised if the device would not obey the 7 second timeout rule
> that seems to be set in stone and not allow more dirty in-drive cache
> than it could flush out in approximately that time.

AFAIK Windows flush-cache timeout is 30 seconds, not 7 as with other 
commands...


> And BUSY should also be set for that case, as Robert indicates.

Agreed.

	Jeff



