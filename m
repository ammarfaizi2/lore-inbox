Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUJDMx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUJDMx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 08:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUJDMx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 08:53:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:14567 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268129AbUJDMx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 08:53:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9-rc3] suspend-to-disk oddities
Date: Mon, 4 Oct 2004 14:56:26 +0200
User-Agent: KMail/1.6.2
Cc: Jan De Luyck <lkml@kcore.org>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net
References: <200410041107.12049.lkml@kcore.org> <200410041406.40222.oliver@neukum.org> <200410041422.25395.lkml@kcore.org>
In-Reply-To: <200410041422.25395.lkml@kcore.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041456.27350.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 of October 2004 14:22, Jan De Luyck wrote:
[-- snip --]
> > Does "cat /proc/bus/usb/devices" give you an empty file or does it hang?
> > Is that modular USB or is it compiled into the kernel? OHCI or UHCI?
> 
> UHCI. I just did a test-suspend-resume, currently plugged USB devices don't 
work, but it does show up in the devices file. It also responds to 
replugging.... I don't get it.
>  I had no response whatsoever earlier. Mouse doesn't work until replugged, 
lots of messages like this in dmesg:
> 
> Oct  4 14:16:49 precious kernel: drivers/usb/input/hid-core.c: input irq 
status -84 received
> Oct  4 14:16:54 precious last message repeated 209 times

Have you tried booting with pci=routeirq?  It may help.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
