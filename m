Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264851AbRF3HUz>; Sat, 30 Jun 2001 03:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbRF3HUp>; Sat, 30 Jun 2001 03:20:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16654 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264851AbRF3HU3>; Sat, 30 Jun 2001 03:20:29 -0400
Subject: Re: Intel SRCU3-1 RAID (I2O) and 2.4.5-ac18
To: pt@procomnet2.prograine.net
Date: Sat, 30 Jun 2001 08:20:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106300635050.1166-100000@procomnet2.prograine.net> from "pt@procomnet2.prograine.net" at Jun 30, 2001 07:41:38 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15GF33-0001ge-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the filesystem on the RAID to another results in something like:
> 
> i2o/iop0: No handler for event (0x00000400)
> i2o/iop0 requires user configuration

That bit is fine. The device is asking you to comfigure it and it also sent
a DDM availability chnage for some reason

> Driver "I2O Block OSM" did not release device!
> i2ob_del_device called, but not in dev table!
> Driver "I2O Block OSM" did not release device!

If you can repeat it in 2.4.5 let me know. I fixed a very similar problem
the supertrak 100 showed up. ALso set up the i2o cgi tools and see why
the device wants to talk to you
