Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUHHVug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUHHVug (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 17:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUHHVug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 17:50:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:46728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263943AbUHHVud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 17:50:33 -0400
Date: Sun, 8 Aug 2004 14:41:18 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Davy Durham <davy@networkstreaming.com>
Cc: sebastien.yapo@e-neyret.com, linux-kernel@vger.kernel.org
Subject: Re: disabling all video
Message-Id: <20040808144118.01446910.rddunlap@osdl.org>
In-Reply-To: <41152A64.6060405@networkstreaming.com>
References: <4113E0FE.1040506@networkstreaming.com>
	<200408070008.42519.sebastien.yapo@e-neyret.com>
	<41152A64.6060405@networkstreaming.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Aug 2004 14:15:48 -0500 Davy Durham wrote:

| Perhaps is there a way/trick to accomplish this by explicitly breaking 
| (*at* runtime/kernel-parameter-time) the vga support that wouldn't cause 
| a panic?

Perhaps there could be a way (most likely there could be), but there
isn't a way currently that I can find in source files or in
Documentation/kernel-parameters.txt .


| Yapo Sebastien wrote:
| 
| >>Question: I would like the kernel not to use any of the video hardware
| >>on the machine.  Is there any run-time kernel parameter I can pass to
| >>disable all video?  (I tried console= to direct output to the serial
| >>port, but ttys were still using the vga hardware.)  My video card is
| >>built onto the mother board, and there is no way I see to disable it
| >>from the BIOS.
| >>
| >>    
| >>
| >Remove "if EMBEDDED" in the VT and VT_CONSOLE section of drivers/char/Kconfig 
| >then reconfigure your kernel.
| >You should find the old VT options in Device Drivers  -> Character devices
| >
| >Regards
| >
| >Sebastien


--
~Randy
