Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUHWQLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUHWQLb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUHWQJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 12:09:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4301 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266081AbUHWQHr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 12:07:47 -0400
Message-ID: <412A1645.4070200@pobox.com>
Date: Mon, 23 Aug 2004 12:07:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
References: <20040802131150.GR10496@suse.de> <200408211913.47982.bzolnier@elka.pw.edu.pl> <20040823121540.GN2301@suse.de> <200408231702.54426.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200408231702.54426.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a tangent...


Per-host synchronization is REQUIRED for controllers which indicate 
"simplex" BMDMA.  And I think for some strange non-simplex controllers 
too (though I guess they could be classified as simplex).

	Jeff



