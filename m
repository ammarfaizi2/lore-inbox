Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUDSPcv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUDSPcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:32:50 -0400
Received: from hauptpostamt.charite.de ([193.175.66.220]:62179 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S264258AbUDSPc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:32:29 -0400
Date: Mon, 19 Apr 2004 17:32:20 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc1 visor USB - data xfer fails
Message-ID: <20040419153220.GE30650@charite.de>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>
References: <407FFB5E.4070406@rgadsdon2.giointernet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <407FFB5E.4070406@rgadsdon2.giointernet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>:
> Data transfer/sync to Clie via visor/USB fails/disconnects with 2.6.6-rc1:
> 
> (from var/log/messages)
> Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: visor_write - 
> usb_submit_urb(write bulk) failed with status = -19
> Apr 16 12:04:27 xxlinux last message repeated 12 times
> Apr 16 12:04:27 xxlinux udev[8283]: removing device node '/udev/ttyUSB1'
> Apr 16 12:04:27 xxlinux udev[8297]: removing device node '/udev/ttyUSB2'
> Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: visor_write - 
> usb_submit_urb(write bulk) failed with status = -19
> Apr 16 12:04:27 xxlinux last message repeated 8 times
> Apr 16 12:04:27 xxlinux kernel: visor ttyUSB1: Handspring Visor / Palm 
> OS converter now disconnected from ttyUSB1
> Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: Handspring Visor / Palm 
> OS converter now disconnected from ttyUSB2

Same here with 2.6.6-rc1-mm1:

Apr 19 14:19:54 hummus2 kernel: visor ttyUSB1: visor_write - usb_submit_urb(write bulk) failed with status = -19
Apr 19 14:19:56 hummus2 kernel: visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
Apr 19 14:19:56 hummus2 kernel: visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
Apr 19 14:22:38 hummus2 kernel: visor 2-2.3:1.0: Handspring Visor / Palm OS converter detected
Apr 19 14:23:27 hummus2 kernel: visor 2-2.3:1.0: device disconnected
Apr 19 14:23:42 hummus2 kernel: visor ttyUSB1: visor_write - usb_submit_urb(write bulk) failed with status = -19
Apr 19 14:26:09 hummus2 kernel: visor 2-2.3:1.0: Handspring Visor / Palm OS converter detected
Apr 19 14:26:09 hummus2 usb.agent[20908]:      visor: already loaded

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
IT-Zentrum Standort Campus Mitte                          AIM.  ralfpostfix
