Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWGKTbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWGKTbB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWGKTbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:31:01 -0400
Received: from fmr18.intel.com ([134.134.136.17]:41943 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751204AbWGKTbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:31:00 -0400
Date: Tue, 11 Jul 2006 12:30:48 -0700
From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 on thinkpad x32
Message-Id: <20060711123048.522ba85c.kristen.c.accardi@intel.com>
In-Reply-To: <20060709225208.GA1787@elf.ucw.cz>
References: <20060709225208.GA1787@elf.ucw.cz>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.19; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 00:52:08 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> * acpi problems are gone, good -- it now boots with acpi=off and boots
> with enabled pci hotplugging.
> 
> 	(that uncovered other problem where machine dies if I try to
> 	undock it... This has worked before. I'll report it properly.)
>

When you get your report for this ready, try to observe whether it happens
if you boot undocked, then dock and then undock, or whether it will
happen if you boot docked, then undock.  I do have an outstanding issue
with some docks that have ide ports on the station where if you boot
docked, then undock, we can't properly remove the ide device.  I am 
working on that one, but it's not solved yet.
 
