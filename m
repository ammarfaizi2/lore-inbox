Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUB1Ons (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 09:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUB1Ons
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 09:43:48 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:48613 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261851AbUB1Onr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 09:43:47 -0500
Date: Sat, 28 Feb 2004 09:41:34 -0500
From: Ben Collins <bcollins@debian.org>
To: Subodh Shrivastava <subodh@btopenworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sbp2 module not initialising external hdd connected on firewire port.
Message-ID: <20040228144134.GC1152@phunnypharm.org>
References: <40409D0A.8040903@btopenworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40409D0A.8040903@btopenworld.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 28, 2004 at 01:52:10PM +0000, Subodh Shrivastava wrote:
> Hi Ben,
> 
> I am trying to connect my external HDD on firewire port. Linux is not 
> recognising this disk. Same disk is recognised in windows, also its 
> recognised in linux when connected on USB port. Attached here is my 
> .config file, lspci output, dmesg output.
> 
> uname -a:
> Linux subbu 2.6.3-mm2 #9 Sat Feb 28 13:11:28 GMT 2004 i686 Intel(R) 
> Pentium(R) M processor 1300MHz GenuineIntel GNU/Linux

Can you do "ls -l /sys/bus/ieee1394/devices/" ?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
