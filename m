Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbVBUUkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbVBUUkU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVBUUkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:40:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46727 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262096AbVBUUkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:40:14 -0500
Message-ID: <421A471A.7090503@pobox.com>
Date: Mon, 21 Feb 2005 15:39:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/ne3210.c: cleanups
References: <20050218234659.GC4337@stusta.de> <42193BFD.9070900@pobox.com> <20050221144809.GC3187@stusta.de>
In-Reply-To: <20050221144809.GC3187@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> @@ -197,7 +194,7 @@
>  	ei_status.priv = phys_mem;
>  
>  	if (ei_debug > 0)
> -		printk(version);
> +		printk("ne3210 driver");


missing newline.  Do something like "ns3210 __DATE__ loaded.\n"

Ditto for seeq8002.

	Jeff


