Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWGCRz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWGCRz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWGCRz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:55:56 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:41451 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751226AbWGCRz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:55:56 -0400
Date: Mon, 03 Jul 2006 13:55:28 -0400
From: Andy Gay <andy@andynet.net>
Subject: Re: [PATCH] Airprime driver improvements to allow full speed EvDO
	transfers
In-reply-to: <20060703170040.GA15315@suse.de>
To: Greg KH <gregkh@suse.de>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, Ken Brush <kbrush@gmail.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Message-id: <1151949329.3285.545.camel@tahini.andynet.net>
MIME-version: 1.0
X-Mailer: Evolution 2.4.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1151646482.3285.410.camel@tahini.andynet.net>
	<adad5cnderb.fsf@cisco.com> <1151872141.3285.486.camel@tahini.andynet.net>
	<20060703170040.GA15315@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-03 at 10:00 -0700, Greg KH wrote:
> Yes, this driver is already split into 2 different ones (look in the
> recent -mm releases).  Sierra wants to have their devices be in their
> own driver, as the chip is a little different from the other ones.  This
> means that those devices are now controlled by a driver called "sierra"
> and the other devices still are working with the airprime driver.
> 
> This should hopefully fix the different endpoint issue, and allow new
> devices to be supported properly, as Sierra Wireless is now maintaining
> that driver.
Aha, good news. So this patch is already obsolete, for the Sierra stuff
anyway. And as I only have Sierra kit to work with, I reckon I should
drop out of this now.
I did make some changes to the last patch to do the cleanup stuff in the
open function, do you want to see those?

> Hope this helps,
> 
Sure does!

> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

