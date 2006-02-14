Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWBNRh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWBNRh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWBNRh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:37:28 -0500
Received: from 213-140-2-71.ip.fastwebnet.it ([213.140.2.71]:23269 "EHLO
	aa004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1422699AbWBNRh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:37:28 -0500
Date: Tue, 14 Feb 2006 18:38:52 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [trivial PATCH] "drivers/usb/media/stv680.h": fix jiffies
 timeout --
Message-ID: <20060214183852.0cdf6f62@localhost>
In-Reply-To: <20060214161535.GD5689@us.ibm.com>
References: <20060214163312.22960006@localhost>
	<20060214161535.GD5689@us.ibm.com>
X-Mailer: Sylpheed-Claws 2.0.0-rc4 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 08:15:35 -0800
Nishanth Aravamudan <nacc@us.ibm.com> wrote:

> 
> NACK. PENCAM_TIMEOUT is a *milliseconds* timeout value.
> 
> From the comment for usb_control_msg:
> 
>  *      @timeout: time in msecs to wait for the message to complete before
>  *              timing out (if 0 the wait is forever)
> 
> Milliseconds do not depend on HZ in anyway.
> 
> Thanks,
> Nish

Opsss... I was using a source browser ;)

http://lxr.linux.no/source/drivers/usb/core/message.c#L118

It's a bit outdated... (2.6.11)

-- 
	Paolo Ornati
	Linux 2.6.15.4-suspend2 on x86_64


-- 
	Paolo Ornati
	Linux 2.6.15.4-suspend2 on x86_64
