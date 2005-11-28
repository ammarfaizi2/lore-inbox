Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbVK1Er4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbVK1Er4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 23:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVK1Erz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 23:47:55 -0500
Received: from xenotime.net ([66.160.160.81]:949 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751139AbVK1Erz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 23:47:55 -0500
Date: Sun, 27 Nov 2005 20:48:24 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alternatives to serial console for oops.
Message-Id: <20051127204824.2758c534.rdunlap@xenotime.net>
In-Reply-To: <4389D63B.4000702@superbug.demon.co.uk>
References: <4389D63B.4000702@superbug.demon.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005 15:52:27 +0000 James Courtier-Dutton wrote:

> Hi,
> 
> I wish to view the oops that are normally output on the serial port of 
> the PC. The problem I have, is that my PC does not have a serial port.
> Are there any alternatives for getting that vital oops from the kernel 
> just as it crashes apart from the serial console.
> Could I get it to use some other interface? e.g. Network interface.
> Parallel port is also not an option.

If the oops occurs after booting (e.g., it's in a module that you
can load after boot to cause the oops) and if you have USB ports
and a usb-serial converter device, you should be able to use
usb-console output to capture the oops.

---
~Randy
