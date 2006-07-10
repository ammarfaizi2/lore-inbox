Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWGJHzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWGJHzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 03:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWGJHzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 03:55:52 -0400
Received: from ns2.g-housing.de ([81.169.133.75]:31165 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S1751298AbWGJHzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 03:55:51 -0400
Date: Mon, 10 Jul 2006 08:55:46 +0100 (BST)
From: Christian Kujau <evil@g-house.de>
X-X-Sender: evil@sheep.housecafe.de
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: ohci1394: aborting transmission
In-Reply-To: <44B203F4.1030903@s5r6.in-berlin.de>
Message-ID: <Pine.LNX.4.64.0607100852390.13858@sheep.housecafe.de>
References: <Pine.LNX.4.64.0607100527200.10447@sheep.housecafe.de>
 <44B203F4.1030903@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006, Stefan Richter wrote:
> Perhaps you should add a printk at the beginning of input's init
> function. The delay could happen during the startup of the input layer
> instead of the 1394 drivers.

yeah, I'll try to do this later on....getting some sleep first...

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/
> and start bisecting within the set of 1394 patches. Among them, the
> patches to sbp2, dv1394, and raw1394 are unrelated to the problem. Note
> that "origin.patch" touches drivers/ieee1394/ too.

OK, thanks for the hint.

> The VIA VT6306 OHCI controller which you have according to your lspci
> output is known to work; yours doesn't even have the small quirk
> mentioned in http://www.linux1394.org/view_device.php?id=713 .

yes, it worked before with no delay and even now all seems to be 
fine after the delay....

Thanks,
Christian.
-- 
BOFH excuse #193:

Did you pay the new Support Fee?
