Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTDWUbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTDWUbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:31:42 -0400
Received: from [81.80.245.157] ([81.80.245.157]:35815 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id S264245AbTDWUbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:31:41 -0400
Date: Wed, 23 Apr 2003 22:42:58 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Ben Collins <bcollins@debian.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423204258.GB10567@vitel.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Ben Collins <bcollins@debian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423202453.GA354@phunnypharm.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 04:24:53PM -0400, Ben Collins wrote:

> This is the same oops I get except that for me I see it as a left over
> scsi device even after sbp2 is unloaded (unload sbp2 and check
> /proc/partitions). 

Confirmed. sbp2 isn't loaded anymore but I still have sdb1/sdb2
in /proc/partitions, and even sdc1/sdc2 which must have been
created when I plugged the iPod the second time.

> I haven't been able to figure out how to get the scsi
> subsystem to remove devices in this condition:

Well, hopefully someone here will direct you towards the 
correct solution before 2.4.21 gets final... Firewire devices
tend to be plugged / unplugged quite often.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
