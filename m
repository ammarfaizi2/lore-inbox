Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCBGCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 01:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUCBGCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 01:02:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:49539 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbUCBGCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 01:02:50 -0500
Date: Mon, 1 Mar 2004 21:58:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: wa1ter@myrealbox.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.x]  USB Zip drive kills ps2 mouse.
Message-Id: <20040301215851.737c433d.rddunlap@osdl.org>
In-Reply-To: <20040301122450.69a1f36e.rddunlap@osdl.org>
References: <20040301122450.69a1f36e.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: walt
| To: Linux Kernel <linux-kernel@vger.kernel.org>
| Subject: [2.6.x]  USB Zip drive kills ps2 mouse.
| 
| 
| Could I ask anyone with a USB Zip drive and a ps2 mouse to try
| to confirm this bizarre bug for me?
| 
| To reproduce it should be simple:
| 
| 1)  Compile USB support as modular, *not* compiled in.
| 
| 2)  The USB Zip drive *must* be plugged in during boot.
|      This bug won't show if you plug in the drive later.
| 
| 3)  Reboot and see if your ps2 mouse works.

Hi,

I'm not seeing a problem with this.  I'm using 2.6.4-rc1.

However, you didn't mention what modules were being loaded
automatically, so we could have a difference in that area.
If you care to specify a module list, I can test it again.

And is your USB Zip drive on a UHCI or OHCI controller?
I have both, so I can test it either way.

--
~Randy
