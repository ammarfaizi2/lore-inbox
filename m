Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVB0R7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVB0R7j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVB0R6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:58:43 -0500
Received: from mx2.mail.ru ([194.67.23.122]:41556 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261469AbVB0R5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:57:00 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Build failure of drivers/usb/gadget/ether.c
Date: Sun, 27 Feb 2005 20:57:08 +0200
User-Agent: KMail/1.6.2
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <200502272021.54173.adobriyan@mail.ru> <20050227173726.GE6148@stusta.de>
In-Reply-To: <20050227173726.GE6148@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502272057.08122.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 19:37, Adrian Bunk wrote:
> On Sun, Feb 27, 2005 at 08:21:54PM +0200, Alexey Dobriyan wrote:
> 
> > FYI, allyesconfig on sparc gives:
> > 
> >   CC      drivers/usb/gadget/ether.o
> > drivers/usb/gadget/ether.c: In function `eth_bind':
> > drivers/usb/gadget/ether.c:2418: error: `control_intf' undeclared (first use in this function)
> > drivers/usb/gadget/ether.c:2418: error: (Each undeclared identifier is reported only once
> > drivers/usb/gadget/ether.c:2418: error: for each function it appears in.)
> > make[3]: *** [drivers/usb/gadget/ether.o] Error 1
> 
> You didn't mention which kernel version you are using and didn't send 
> your .config .
> 
> But this looks like an issue already fixed in Greg's tree.
> Can you confirm it's fixed in 2.6.11-rc4-mm1?

Indeed fixed.

	Alexey
