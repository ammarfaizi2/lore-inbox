Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbTI3BtW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 21:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTI3BtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 21:49:22 -0400
Received: from EPRONET.01.dios.net ([65.222.230.105]:10881 "EHLO
	mail.eproinet.com") by vger.kernel.org with ESMTP id S263074AbTI3BtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 21:49:21 -0400
Date: Mon, 29 Sep 2003 21:16:42 -0400 (EDT)
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pm: Revert swsusp to 2.6.0-test3
In-Reply-To: <Pine.LNX.4.44.0309291747020.968-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309292113200.6091-100000@llave.eproinet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, Patrick Mochel wrote:

> 
> > Are both versions compatible? How to resume the right version?
> > Or simply resume=/dev/hda3 and the kernel will pick the right
> > mechanism to resume? 
> 
> No, they are not compatible. The resume= command line parameter will be 
> trapped by the swsusp code. When using pmdisk, you may set the partition 
> you want to use for suspend/resume via the CONFIG_PMDISK_PARTITION 
> compile-time option. Or, you may override that using the pmdisk= command 
> line parameter. 
> 
> I realize it's a bit confusing, but I will write documentation that 
> explicitly describes the differences within the week.

While you're at it, please throw in some notes about how to resume from
memory too. I just started playing with it and, although it suspends
great I see no obvious way to wake it up. (Power button flashes lights
once on & off. Next power press reboots.)

-- 
Mark W. Alexander
slash@dotnetslash.net

