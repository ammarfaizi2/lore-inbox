Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271386AbTHDFv5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271388AbTHDFv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:51:57 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:57314 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S271386AbTHDFv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:51:56 -0400
Date: Mon, 4 Aug 2003 01:34:38 -0400
From: Ben Collins <bcollins@debian.org>
To: Steven Micallef <steven.micallef@world.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: chroot() breaks syslog() ?
Message-ID: <20030804053438.GC31092@phunnypharm.org>
References: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 03:49:48PM +1000, Steven Micallef wrote:
> You're right - my mistake, it doesn't actually work on 2.4.8 either, I think
> I was looking at the wrong thing when I thought it was actually working.
> 
> Is it worth considering (optionally) making /dev available to chroot()'ed
> environments, or would that just defeat the whole purpose of chroot()?

Enable devfs, and you can mount devfs anywhere, even in chroots, and it
will propogate things like /dev/log.

Generally chroot environments don't want that though.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
