Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVGNGbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVGNGbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 02:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVGNGbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 02:31:03 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:31385 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262866AbVGNGa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 02:30:57 -0400
Message-ID: <42D6069E.1040208@gentoo.org>
Date: Thu, 14 Jul 2005 07:30:54 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050710)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ludovic Drolez <ludovic.drolez@linbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12: yukon2 nics still not supported...
References: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org> <3F378FC3.1020507@freealter.com> <42D5268B.7050108@linbox.com>
In-Reply-To: <42D5268B.7050108@linbox.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ludovic Drolez wrote:
> I recently had to boot a brand new system using a Marvel Yukon2 NIC
> (sk98lin) driver which is not supported by the latest kernel (pci ids =
> 11ab:4361).
> 
> So I compiled the GPLed driver available from Syskonnect,
> http://www.syskonnect.com/syskonnect/support/driver/d0102_driver.html,
> which works perfectly.
> 
> So, I wonder why the sk98lin driver is not up to date in the 2.6.x
> kernels ?

The recent updates to sk98lin do not adhere to Linux coding standards so have
been rejected by the network driver maintainers.

Most of sk98lin has been reimplemented as the skge driver, to be included in
2.6.13. This driver covers the original yukon cards.

In time, another new driver will be written for the yukon-II range. To assist,
you could write to the linux-netdev mailing list, offering to test any new
drivers once they go into development.

Daniel
