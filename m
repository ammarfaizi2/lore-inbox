Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbUKECZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbUKECZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbUKECZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:25:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32167 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262563AbUKECZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:25:36 -0500
Message-ID: <418AE490.1010304@pobox.com>
Date: Thu, 04 Nov 2004 21:25:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH RESEND] pcmcia network drivers cleanup
References: <20041104112736.GT3472@crusoe.alcove-fr>
In-Reply-To: <20041104112736.GT3472@crusoe.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> Hi,
> 
> The attached patch:
>   * cleans up the parameter passing (module_param() instead of MODULE_PARM()
>   * makes debugging work (PCMCIA_DEBUG does not exist anymore, make the
>     Makefile test for CONFIG_PCMCIA_DEBUG and activate DEBUG in CFLAGS)
>     and use the same debugging macros for every driver through code
>     reuse.

Comments:

1) Can you please separate module_param() and PCMCIA_DEBUG patches?

2) why not use pr_debug()?

	Jeff



