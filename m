Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbTIPN6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 09:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbTIPN6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 09:58:16 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:7845 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261894AbTIPN6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 09:58:14 -0400
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309152229390.5337-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0309152229390.5337-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063720608.10036.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Tue, 16 Sep 2003 14:56:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-16 at 03:38, Thomas Molina wrote:
> It seems to me that if you are in the position of tinkering, and 
> installing an OS you ought to have an understanding of root and boot 
> disks, and what is in your system.  If you don't understand things well 
> enough to specify the proper boot disk and root disk you shouldn't be 
> tinkering and it won't matter how each is specified.

Your root disk can change for all sorts of non Linux reasons ranging
from windows config changes to hotplug devices. For example if your root
is /dev/sdc and /dev/sdb fails you'll want LABEL=.

