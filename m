Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310151AbSCKPVy>; Mon, 11 Mar 2002 10:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310155AbSCKPVo>; Mon, 11 Mar 2002 10:21:44 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52748 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S310151AbSCKPVa>; Mon, 11 Mar 2002 10:21:30 -0500
Date: Mon, 11 Mar 2002 16:21:21 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Ext2/3 uid/gid support
Message-ID: <20020311152121.GA14712@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E16j1Z6-0002xf-00@the-village.bc.nu> <02031109444400.00601@huschki> <20020311084741.GC311@matchmail.com> <02031110223301.00601@huschki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02031110223301.00601@huschki>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Erik Meusel wrote:

> The reason why I ask is, I have two linux stations and I want to use ext2
> for the floppy disks to save space for fat vfat and so on. Now it would
> be nice to automatically mount my floppies with group "floppy", so that
> all the users, belonging to group "floppy", can read/write from/to disk.

Please read your mount and fstab man pages. Look for the "user" option.
BTW, these uid/gid options would not help you any further, as has been
said, because mount is always a privileged operation.

-- 
Matthias Andree
