Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUK0NVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUK0NVR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 08:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbUK0NVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 08:21:17 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:32480 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261207AbUK0NVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 08:21:14 -0500
To: Herbert Xu <herbert@gondor.apana.org.au>, pavel@ucw.cz,
       linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 9/51: init/* changes.
In-Reply-To: <E1CXyvo-0002LS-00@gondolin.me.apana.org.au>
References: <20041127072224.GM1417@openzaurus.ucw.cz> <E1CXyvo-0002LS-00@gondolin.me.apana.org.au>
Date: Sat, 27 Nov 2004 13:21:14 +0000
Message-Id: <E1CY2Vm-0004LQ-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>> Given it is not too intrusive... why not. Send it for comments.
>> I probably will not use this myself, so you'll need to test/maintain
>> it.
> 
> This shouldn't be necessary.  Since the resume is being initiated by
> userspace, it can perform the function of name_to_dev_t and just feed
> the numbers to the kernel.  The code to do that is still in Debian's
> initrd-tools.

Good point. Ok, what's the best way to present this to userspace? Add a
/sys/power/resume and then echo a major:minor in there?

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
