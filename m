Return-Path: <linux-kernel-owner+w=401wt.eu-S932206AbXAHIue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbXAHIue (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbXAHIue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:50:34 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:65409 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932206AbXAHIud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:50:33 -0500
X-Greylist: delayed 1448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jan 2007 03:50:32 EST
Date: Mon, 8 Jan 2007 09:26:19 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove a couple final references to obsolete
 verify_area().
Message-ID: <20070108092619.3efb86f8@dhcp-252-105.norway.atmel.com>
In-Reply-To: <Pine.LNX.4.64.0701071839560.18341@localhost.localdomain>
References: <Pine.LNX.4.64.0701071839560.18341@localhost.localdomain>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 18:43:41 -0500 (EST)
"Robert P. J. Day" <rpjday@mindspring.com> wrote:

> 
>   Remove a couple final references to the obsolete verify_area() call,
> which was long ago replaced by access_ok().
> 
> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

Acked-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

>   it *appears* that these last two references can be removed, unless
> there's something really strange i'm not seeing here.

The kernel builds and boots fine after applying this patch, so I think
verify_area is indeed unused. If it breaks something outside of
mainline, I guess it's about time we get it fixed.

Thanks,

Haavard
