Return-Path: <linux-kernel-owner+w=401wt.eu-S1422787AbXAMUbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422787AbXAMUbh (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 15:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbXAMUbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 15:31:37 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:11772 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422787AbXAMUbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 15:31:36 -0500
Date: Sat, 13 Jan 2007 15:31:19 -0500
From: Eric Buddington <ebuddington@verizon.net>
Subject: 2.6.20-rc4-mm1 USB (asix) problem
To: linux-kernel@vger.kernel.org
Reply-to: ebuddington@wesleyan.edu
Message-id: <20070113203113.GB14587@pool-71-123-103-45.spfdma.east.verizon.net>
Organization: ECS Labs
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
X-Eric-conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following problem occured on an Athlon64 X2 under 2.6.20-rc4-mm1,
but not 2.6.20-rc3-mm1.

I'm using two D-Link DUB-E100 USB ethernet adapters, using the 'asix'
driver. When I upgraded to 2.6.20-rc4-mm1, they were still recognized,
but various ifconfig operations on them (up/down, changing IP) caused
a system freeze (including caps lock/num lock lights) for many seconds.
I do not believe there was anything new in dmesg when the system
resumed. USB debugging was not turned on at the time, though the
problem is repeatable.

Also, no packets actually made it out of the adapters (watching from
other systems on the network).

Since this is a system we need running and networked, I can't do
extensive testing on it, but I might be to bring it down for a few
quick tests if that would help.

-Eric

