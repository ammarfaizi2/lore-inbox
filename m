Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUFNRub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUFNRub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 13:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUFNRua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 13:50:30 -0400
Received: from holomorphy.com ([207.189.100.168]:39585 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263731AbUFNRu3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 13:50:29 -0400
Date: Mon, 14 Jun 2004 10:50:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614175015.GO1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dominik Karall <dominik.karall@gmx.net>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
References: <20040614021018.789265c4.akpm@osdl.org> <200406141620.01731.dominik.karall@gmx.net> <20040614141942.GF1444@holomorphy.com> <200406141958.29040.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406141958.29040.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 07:58:25PM +0200, Dominik Karall wrote:
> OK, I greped through the usb sources and searched for the message
> string, so I get a match in drivers/usb/core/message.c.
> I removed the message.c patch from -mm2 patch and it works now
> without those error messages.
> @William
> thx for your explanation! :)
> This is the patch I removed(!):
> -----------------------------------------------------
> diff -Nru a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> --- a/drivers/usb/core/message.c	2004-06-14 00:07:35 -07:00
> +++ b/drivers/usb/core/message.c	2004-06-14 00:07:35 -07:00
> @@ -566,22 +566,19 @@
>   */
>  int usb_get_descriptor(struct usb_device *dev, unsigned char type, unsigned 
> char index, void *buf, int size)

Thanks for your patience testing. Your regression testing efforts were
very helpful.


-- wli
