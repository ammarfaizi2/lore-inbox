Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312450AbSC2EBK>; Thu, 28 Mar 2002 23:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312695AbSC2EA7>; Thu, 28 Mar 2002 23:00:59 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:32433 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S312450AbSC2EAn>; Thu, 28 Mar 2002 23:00:43 -0500
Date: Thu, 28 Mar 2002 23:00:32 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Walburn <matt@math.mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mkinitrd w/ 2.4.18
Message-ID: <20020328230032.A2627@devserv.devel.redhat.com>
In-Reply-To: <mailman.1017365942.20950.linux-kernel2news@redhat.com> <200203290248.g2T2mDA29032@devserv.devel.redhat.com> <20020328220130.A2627@math.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Thu, 28 Mar 2002 22:01:30 -0500
> From: Matthew Walburn <matt@math.mit.edu>

> Specifically, i get the error message:
> "all of your loopback devices are in use"

Unfortunately, it only says that setting up the loopback failed.
You are not necesserily running out of free loopback devices.
Does mounting anything on the loopback work?
mount -t iso9660 -o loop /your/favourite/something.iso /mnt/cdrom

I'll drop cc on the next round.

-- Pete
