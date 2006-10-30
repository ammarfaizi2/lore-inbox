Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWJ3S7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWJ3S7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161390AbWJ3S7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:59:49 -0500
Received: from rtr.ca ([64.26.128.89]:22033 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161385AbWJ3S7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:59:47 -0500
Message-ID: <45464BA0.8070106@rtr.ca>
Date: Mon, 30 Oct 2006 13:59:44 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
References: <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk> <454644C1.4080702@rtr.ca> <20061030185214.GH14055@kernel.dk>
In-Reply-To: <20061030185214.GH14055@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>
> Bingo, that's a lot better! So that's the real bug, I'm guessing this
> got introduced when the ioprio stuff got juggled around recently. Pretty
> straight forward, this should fix it for you.

And it does indeed fix it, thanks!

-ml
