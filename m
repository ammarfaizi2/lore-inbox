Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVB0SC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVB0SC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVB0Rwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:52:44 -0500
Received: from mx2.mail.ru ([194.67.23.122]:61240 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261469AbVB0Rls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:41:48 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: Build failure of drivers/usb/gadget/ether.c
Date: Sun, 27 Feb 2005 20:41:56 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200502272021.54173.adobriyan@mail.ru>
In-Reply-To: <200502272021.54173.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502272041.56378.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 February 2005 20:21, Alexey Dobriyan wrote:
> FYI, allyesconfig on sparc gives:
> 
>   CC      drivers/usb/gadget/ether.o
> drivers/usb/gadget/ether.c: In function `eth_bind':
> drivers/usb/gadget/ether.c:2418: error: `control_intf' undeclared (first use in this function)
> drivers/usb/gadget/ether.c:2418: error: (Each undeclared identifier is reported only once
> drivers/usb/gadget/ether.c:2418: error: for each function it appears in.)

Seen on 2.6.11-rc5.

	Alexey
