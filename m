Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266246AbUGJNuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUGJNuU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 09:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUGJNuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 09:50:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266246AbUGJNuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 09:50:16 -0400
Date: Sat, 10 Jul 2004 14:50:15 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Massimo Cetra <mcetra@navynet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount -o bind strange behaviour
Message-ID: <20040710135015.GR12308@parcelfarce.linux.theplanet.co.uk>
References: <002401c46682$7c355c70$e60a0a0a@guendalin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002401c46682$7c355c70$e60a0a0a@guendalin>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2004 at 03:33:28PM +0200, Massimo Cetra wrote:
> I have mounted several directories with option -o bind in order to have
> some files avalaible in a chroot.
> 
> Mount -o bind /dir1 /dir2
> 
> Yesterday I noticed that modifying some files in /dir1 didn't cause the
> corresponding files in /dir2 to be modified.
> It happened only for one mountpoint, not for the otner similar
> mountpoints.
> Umount && mount solved the problem.
> 
> The only strange thing is that some hours before i noticed this
> behaviour, machine load reached 150 (apache was overloaded)
> 
> Is it a bug somewhere in the kernel ?

No way to tell without at least the contents of your /proc/mounts before and
after...
