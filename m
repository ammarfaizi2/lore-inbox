Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbUDNUjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUDNUjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:39:13 -0400
Received: from mail1.kontent.de ([81.88.34.36]:23436 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261661AbUDNUjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:39:12 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Duncan Sands <baldrick@free.fr>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] [PATCH 7/9] USB usbfs: destroy submitted urbs only on the disconnected interface
Date: Wed, 14 Apr 2004 22:39:08 +0200
User-Agent: KMail/1.5.1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Frederic Detienne <fd@cisco.com>
References: <200404141245.37101.baldrick@free.fr> <200404141733.11599.oliver@neukum.org> <200404141739.56829.baldrick@free.fr>
In-Reply-To: <200404141739.56829.baldrick@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404142239.08408.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I would prefer a real WARN_ON() so that the imbedded people compiling
> > for size are not affected.
>
> What do you mean?  How is a real WARN_ON() better?

WARN_ON can be defined away to make a smaller kernel. Code that does
not use it takes away that option.

	Regards
		Oliver

