Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVHAMaA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVHAMaA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 08:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVHAMaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 08:30:00 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:10159 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261820AbVHAM37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 08:29:59 -0400
Message-ID: <42EE15AF.5050902@hp.com>
Date: Mon, 01 Aug 2005 08:29:35 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
CC: gregkh@suse.de, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Where is place of arch independed companion chips?
References: <42EB6A12.70100@varma-el.com>
In-Reply-To: <42EB6A12.70100@varma-el.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-4.9, required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Volkov wrote:

>Hi Greg,
>
>While I write driver for SM501 CC (which have graphics controller, USB
>MASTER/SLAVE, AC97, UART, SPI  and VIDEO CAPTURE onboard),
>I bumped with next ambiguity:
>Where is a place of this chip's Kconfig/drivers in
>kernel config/drivers tree? May be create new node in drivers subtree?
>Or put it under graphics node (since it's main function of this CC)?
>
>AFAIK, this is not one such multifunctional monster in the world, so
>somebody bumped with this problem again in future.
>
>  
>
Good question.  I was about to submit a patch that created 
drivers/platform because the toplevel driver for MQ11xx is a 
platform_device driver.  Any thoughts on this?

Jamey


