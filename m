Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270032AbTHCUpf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 16:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270218AbTHCUpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 16:45:35 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S270032AbTHCUpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 16:45:34 -0400
Date: Sun, 3 Aug 2003 21:56:14 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308032056.h73KuEem000277@81-2-122-30.bradfords.org.uk>
To: bbeutner@comcast.net, linux-kernel@vger.kernel.org
Subject: Re: issues with any ac sources, and 2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i run a tyan tiger s2462 board with dual athlons, with the gentoo
> flavor on it, recently i tried to run the ac sourcess kernel on this
> machine, however upon boot the machine would just freeze up in the
> middle of kernel boot, either dying while attaching ide's to devices
> or while detecting the ide chipset, the odd part to this is that
> using generic linux sources the machine boots just fine the other
> issue seems to be that using the 2.6-beta versions it panic.
> it does so by telling me that i have corrupt cpu context and then
> panics, there are no hints or warning as to what it could be any
> help would be greatly appreciated

For the AC kernels, try backing out just the IDE patches, and see if
that allows you to boot.

For 2.6, does the machine finish booting, and then panic, or does it
panic during the boot?  Did you try any of the 2.5 kernels, or did you
start with 2.6?  If it panics during boot, does it always panic at the
same place, and if so where?  Posting the boot time output of dmesg,
and lspci -vvv would be helpful here.

John.
