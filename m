Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754143AbWKGJby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbWKGJby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 04:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753328AbWKGJby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 04:31:54 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:11023 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1754143AbWKGJbx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 04:31:53 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.19-rc4] usb urb unlink/free clenup
Date: Tue, 7 Nov 2006 10:30:56 +0100
User-Agent: KMail/1.9.5
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200611062228.38937.m.kozlowski@tuxland.pl> <20061106184949.87b2f23a.akpm@osdl.org>
In-Reply-To: <20061106184949.87b2f23a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611071030.57152.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

> > We do not need to check for urb != NULL before we call them.
> 
> Seems reasonable.
> 
> Your patch had all its tabs replaced with spaces by your email client.  I
> fixed that all up, but it was rather dull work and I'd prefer not to have
> to do it again.

Will investigate - hopefully won't happen again. Sorry.

> > Or maybe there is no need for this?
> > 
> 
> I think it's OK as-is.  Presumably it's rare for a caller to pass in a NULL
> urb.
> 
> It's possible that your proposed change will cause new (and incorrect)
> warnings to be emitted, but we can handle those if/when they come out.

Ok here is the dumb part. Do I send the next diff against the work I already did?

Regards,

	Mariusz Kozlowski
