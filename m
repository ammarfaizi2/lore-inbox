Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVE1NdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVE1NdF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVE1NdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:33:05 -0400
Received: from [217.19.149.7] ([217.19.149.7]:50954 "HELO mail.netline.it")
	by vger.kernel.org with SMTP id S261378AbVE1NdB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:33:01 -0400
Date: Sat, 28 May 2005 15:33:01 +0200
From: Domenico Andreoli <cavok@libero.it>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: netdev-2.6, wireless queues updated
Message-ID: <20050528133301.GA30966@raptus.dandreoli.com>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Netdev <netdev@oss.sgi.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <4297E93D.2060003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4297E93D.2060003@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2005 at 11:45:01PM -0400, Jeff Garzik wrote:
> 
> And finally a patch containing _only_ the changes on the we18-ieee80211 
> branch,
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.12-rc5-git2-ieee80211-1.patch.bz2

jeff, i am using a separate ipw2200 1.0.4 module with the proper hotplug firmware.

after i read this message i wanted to try your patch but during the
build i realized that you may have merged a different version (indeed
it looks like 1.0.0).

i don't really know what would be happened after reboot, using driver
1.0.0 and firmware for 1.0.4. i'd put a big notice in the help of ipw2*
modules about matching driver and firmware versions. mixing them is
probably a bad gift to your hardware.

yes, people should read those readmes.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
