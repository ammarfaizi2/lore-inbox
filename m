Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272784AbTG3Gfq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272785AbTG3Gfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 02:35:46 -0400
Received: from us01smtp2.synopsys.com ([198.182.44.80]:17286 "EHLO
	kiruna.synopsys.com") by vger.kernel.org with ESMTP id S272784AbTG3Gfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 02:35:43 -0400
Date: Wed, 30 Jul 2003 08:35:36 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Grant Miner <mine0057@mrs.umn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zio! compactflash doesn't work
Message-ID: <20030730063536.GL13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Grant Miner <mine0057@mrs.umn.edu>,
	linux-kernel@vger.kernel.org
References: <3F26F009.4090608@mrs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F26F009.4090608@mrs.umn.edu>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Miner, Wed, Jul 30, 2003 00:07:05 +0200:
> I have a Microtech CompactFlash ZiO! USB
...
> but it does not show up in /dev; this is in 2.6.0-pre1.  (It never 
> worked in 2.4 either.)  config is attached.  Any ideas?

It does not have to show up anywere. You have to modprobe sd-mod and
usb_storage first. Than access /dev/sd<something>:

$ mount -t vfat /dev/sda1 /mnt/cf

