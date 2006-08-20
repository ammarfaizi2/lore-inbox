Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWHTBet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWHTBet (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 21:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWHTBes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 21:34:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:21584 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751633AbWHTBer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 21:34:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j3O3x1WBEbZPl2B+mupWhkfI5RBSq/UGmmOqwpfsGUJsAf6vmN4R1rcNhmHQ+beXP0daBWoZNU3aVDBZl0u5EOPlEJRUoS8s2eltQ76B82ZxTkzn7HARl0pdAyLH9SSVeJ9785Z94L1F0DbQvKRMkGASyJ8uPwbQSMF95qepnQU=
Message-ID: <625fc13d0608191834r19ce12e5raccbae011d67c25e@mail.gmail.com>
Date: Sat, 19 Aug 2006 20:34:46 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Re: 2.6.18-rc4 jffs2 problems
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, "Greg KH" <greg@kroah.com>,
       "David Woodhouse" <dwmw2@infradead.org>
In-Reply-To: <1155852587.5530.30.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1154976111.17725.8.camel@localhost.localdomain>
	 <1155852587.5530.30.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/06, Richard Purdie <rpurdie@rpsys.net> wrote:
> Read the return value before we release the nand device otherwise the
> value can become corrupted by another user of chip->ops, ultimately
> resulting in filesystem corruption.
>

We have multiple confirmations that this patch fixes the issue
reported.  I agree it should go in 2.6.18.

Greg, can you add this to your tree?


> Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Acked-by: Josh Boyer <jwboyer@gmail.com>

josh
