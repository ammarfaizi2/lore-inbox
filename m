Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTEHWwh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 18:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTEHWwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 18:52:37 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:58761
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262192AbTEHWwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 18:52:36 -0400
Subject: Re: [PATCH] 2.5 ide 48-bit usage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030508163441.GG20941@suse.de>
References: <20030508161600.GE20941@suse.de>
	 <Pine.LNX.4.44.0305080924400.2967-100000@home.transmeta.com>
	 <20030508163441.GG20941@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052431594.13567.30.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 23:06:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 17:34, Jens Axboe wrote:
> Might not be a bad idea, drive->address_mode is a heck of a lot more to
> the point. I'll do a swipe of this tomorrow, if no one beats me to it.

We don't know if in the future drives will support some random mask of modes.
Would

	drive->lba48
	drive->lba96
	drive->..

be safer ?

