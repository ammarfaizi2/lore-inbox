Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbULRPk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbULRPk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 10:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbULRPk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 10:40:58 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:65435 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261180AbULRPky
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 10:40:54 -0500
Subject: Re: [PATCH] hid-core: Configurable USB HID Mouse Interrupt Polling
	Interval
From: Marcel Holtmann <marcel@holtmann.org>
To: Mikkel Krautz <krautz@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <greg@kroah.com>, Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <41C46B4D.5040506@gmail.com>
References: <1103335970.15567.15.camel@localhost>
	 <20041218012725.GB25628@kroah.com>  <41C46B4D.5040506@gmail.com>
Content-Type: text/plain
Date: Sat, 18 Dec 2004 16:40:44 +0100
Message-Id: <1103384445.8765.1.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikkel,

> @@ -1910,6 +1916,7 @@
>  
>  module_init(hid_init);
>  module_exit(hid_exit);
> +module_param(hid_mouse_polling_interval, int, 644);

I think the use of module_param_named() makes more sense here.

Regards

Marcel


