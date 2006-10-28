Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWJ1TSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWJ1TSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWJ1TSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:18:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8852 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751360AbWJ1TSP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:18:15 -0400
Date: Sat, 28 Oct 2006 12:14:57 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Soeren Sonnenburg <kernel@nn7.de>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Fwd: Re: usb initialization order (usbhid vs. appletouch)
Message-Id: <20061028121457.486c7405.zaitcev@redhat.com>
In-Reply-To: <200610282055.29423.oliver@neukum.name>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	<1162054576.3769.15.camel@localhost>
	<200610282043.59106.oliver@neukum.org>
	<200610282055.29423.oliver@neukum.name>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.6; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006 20:55:03 +0200 (MEST), Oliver Neukum <oliver@neukum.name> wrote:

> Exactly. Combing both patches:
> Soeren, if this works, please sign it off and send it to Greg.
> 
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

This looks good. However, the love of meaningless whitespace makes
me uneasy. It sets us up for double-patching.

> +#define USB_DEVICE_ID_APPLE_GEYSER3_JIS	0x0219
>  #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
>  
> +
>  #define USB_VENDOR_ID_CHERRY		0x046a
>  #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023

-- Pete
