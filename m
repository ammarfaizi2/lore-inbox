Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTLUEXe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 23:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbTLUEXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 23:23:33 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:49070 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262164AbTLUEXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 23:23:32 -0500
Date: Sat, 20 Dec 2003 22:53:48 -0500
From: Ben Collins <bcollins@debian.org>
To: M?ns Rullg?rd <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire/sbp2 troubles with Linux 2.6.0
Message-ID: <20031221035348.GM6607@phunnypharm.org>
References: <yw1x8yl66ecs.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1x8yl66ecs.fsf@ford.guide>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 04:26:11AM +0100, M?ns Rullg?rd wrote:
> 
> I'm having some trouble connecting a Firewire hard disk box to a
> laptop running Linux 2.6.0.  The disk is correctly detected when
> connected, and can be mounted.  The problems start when I try to read
> large files from the disk.  It will start off reading at about 10
> MB/s, which seems a bit slow for Firewire.  The disks I've used are
> capable of much more.  That's not the real problem, though.  After a
> little while, sometimes as little as 1 MB, sometimes after about 50
> MB, the reading will stall and this message is printed in the kernel
> log:
> 
> ieee1394: sbp2: aborting sbp2 command
> 0x28 00 03 6f d2 f1 00 00 f8 00 

Please try the code in the repo on linux1394.org. I've done a lot of
work to sbp2 since my last sync with Linus.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
