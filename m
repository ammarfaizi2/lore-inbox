Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265758AbUFOQ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265758AbUFOQ1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 12:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265760AbUFOQ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 12:27:47 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:20671 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265758AbUFOQ1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 12:27:36 -0400
Date: Tue, 15 Jun 2004 12:05:41 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ieee1394 still utterly broken in 2.6.7-rc3
Message-ID: <20040615160541.GB9456@phunnypharm.org>
References: <20040615155354.GA7988@fefe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615155354.GA7988@fefe.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 05:53:54PM +0200, Felix von Leitner wrote:
> Is it too much to ask to at least revert back to the ieee1394 code from
> 2.6.3 before shipping the final 2.6.7?
> 
> Firewire was dysfunctional sind 2.6.3, and still has not been fixed,
> despite several updates to the code.
> 
> Please, 2.6 is supposed to be a stable kernel, for people to use in
> production environments.
> 
> Here's what happens with every kernel since 2.6.4:
> 
>   kernel boots
>   finds firewire hard disk
>   creates device
>   boot sequence tries to mount disk
>   computer hangs
>   I pull the cable
>   computer continues booting, just without firewire disk
> 
> It's an Athlon mainboard with VIA chipset.

Is firewire built-in to the kernel? I haven't seen any of these problems
_at all_, but I use modules. I have a 250gig firewire disk that is used
for nightly backups for 5 systems via rsync and ssh, and it never shows
any problems.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
