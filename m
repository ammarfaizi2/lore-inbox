Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbTKAIdW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 03:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTKAIdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 03:33:22 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:4826 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S263102AbTKAIdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 03:33:20 -0500
Date: Sat, 1 Nov 2003 10:33:00 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Something corrupts raid5 disks slightly during reboot
Message-ID: <20031101083300.GG4640@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
References: <20031031190829.GM4868@niksula.cs.hut.fi> <3FA30F4A.5030500@hundstad.net> <20031101015733.GA3907@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031101015733.GA3907@matchmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 05:57:33PM -0800, you [Mike Fedyk] wrote:
> On Fri, Oct 31, 2003 at 07:41:30PM -0600, Jeffrey E. Hundstad wrote:
> > Try:
> > 
> > hdparm -W0 /dev/hdX
> > 
> > for each of your ide drives.  This turns off write-caching which is 
> > usually a bad thing with ide drives anyway.
> > 
> 
> Also try installing smartmontools, and run smartmon -a on each of the
> drives.  It might tell you one of the drives is going bad...

I am monitoring all my drives with smart constantly, and they haven't shown
any symptoms. The corruption only happens upon reboot, which is a quite
rare event for a server.

Also, I find that smart rarely gives much useful warnings beforehand when a
drive is about to fail. And when the drive fails I usually get a good doze
of UncorrectableErrors into the log, not silent corruption (and I've seen a
lot drives to fail ;( ). Silent corruption is usually caused by the chipset
or driver (seen that, too ;( ), but it has usually happened under stress,
not when nothing much is being written to the drive.


-- v --

v@iki.fi
