Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUHTQYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUHTQYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268319AbUHTQYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:24:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:40083 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267508AbUHTQYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:24:30 -0400
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: 2.6.8.1-mm2 (nvidia breakage)
Date: Fri, 20 Aug 2004 18:24:32 +0200
User-Agent: KMail/1.7
References: <20040819092654.27bb9adf.akpm@osdl.org> <20040819225848.GE1263@hygelac> <200408200953.11440.bjorn.helgaas@hp.com>
In-Reply-To: <200408200953.11440.bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Terence Ripperda <tripperda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408201824.33004.warpy@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 August 2004 17:53, you wrote:

> I didn't see any oops there.

Hi Bjorn,

i searched my logs and found that.

Aug 20 18:03:53 stargate kernel: irq 16: nobody cared!
Aug 20 18:03:53 stargate kernel:  [<c0106520>] __report_bad_irq+0x24/0x7b
Aug 20 18:03:53 stargate kernel:  [<c01065f9>] note_interrupt+0x64/0x88
Aug 20 18:03:53 stargate kernel:  [<c010694d>] do_IRQ+0x1af/0x1fb
Aug 20 18:03:53 stargate kernel:  [<c0104890>] common_interrupt+0x18/0x20
Aug 20 18:03:53 stargate kernel: handlers:
Aug 20 18:03:53 stargate kernel: [<f9a11145>] (usb_hcd_irq+0x0/0x5d [usbcore])
Aug 20 18:03:53 stargate kernel: [<f9a11145>] (usb_hcd_irq+0x0/0x5d [usbcore])
Aug 20 18:03:53 stargate kernel: Disabling IRQ #16


-- 
Michael Geithe

-
