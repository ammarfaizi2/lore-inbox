Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUEAQrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUEAQrO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUEAQrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 12:47:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:46538 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261380AbUEAQrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 12:47:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: daniel.ritz@gmx.ch, linux-usb-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] new USB HID driver: eGalax Touchscreens
Date: Sat, 1 May 2004 18:47:07 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200405011833.55337.daniel.ritz@gmx.ch>
In-Reply-To: <200405011833.55337.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405011847.07479.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	if (usb_submit_urb(touchkit->irq, GFP_ATOMIC))
> +		return -EIO;

must also decrease the counter

	Regards
		Oliver

