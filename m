Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUHNQ37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUHNQ37 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 12:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUHNQ37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 12:29:59 -0400
Received: from the-village.bc.nu ([81.2.110.252]:19163 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263806AbUHNQ36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 12:29:58 -0400
Subject: Re: legacy VGA device requirements (was: Exposing ROM's though
	sysfs)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Torrey Hoffman <thoffman@arnor.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813235630.89799.qmail@web14928.mail.yahoo.com>
References: <20040813235630.89799.qmail@web14928.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092497235.27144.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 14 Aug 2004 16:27:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-14 at 00:56, Jon Smirl wrote:
> I know internally how to find the VGA cards using the PCI class. I
> meant this in the context of how do you enumerate all of the VGA
> devices in a domain from a user space app. What is the API for this?
> What is the user space API for turning off all of the VGA devices in a
> domain?

I don't follow the logic behind the question. Once you have the vga
locking device then that needs to handle the vga on/off.

