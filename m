Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUENRmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUENRmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUENRmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:42:50 -0400
Received: from host206.200-117-132.telecom.net.ar ([200.117.132.206]:44484
	"EHLO smtp.bensa.ar") by vger.kernel.org with ESMTP id S261943AbUENRml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:42:41 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: does udev support sw raid0?
Date: Fri, 14 May 2004 14:42:38 -0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405141442.38404.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm trying to setup my box to use udev but I'm stuck.

My /home partition is on a software raid0. Using devfs, I have no problems. I 
can "mount /dev/md/0 /home" and I'm done, but udev seems to ignore raid0 
completely. md and raid0 modules are loaded but there're no md/raid devices 
on /dev.

So what's the problem here? Does udev support sw raid0 devices? Or the other 
way around, does sw raid0 support udev?

Many thanks in advance,
Norberto
