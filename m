Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVGIVK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVGIVK5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVGIVK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:10:57 -0400
Received: from [206.246.247.150] ([206.246.247.150]:26849 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261732AbVGIVKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:10:55 -0400
Date: Sat, 9 Jul 2005 17:10:54 -0400
From: Ben Collins <bcollins@debian.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       scjody@modernduck.com, bunk@stusta.de
Subject: Re: alternative [PATCH] 1/2) drivers/ieee1394/: schedule unused EXPORT_SYMBOL's for removal
Message-ID: <20050709211054.GO29099@phunnypharm.org>
References: <20050709075035.GA20151@phunnypharm.org> <200507091032.j69AWXrv027400@einhorn.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507091032.j69AWXrv027400@einhorn.in-berlin.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, but I set the default to "N". No reason to prolong doing it,
since it doesn't break anything in the kernel or in our tree. It's an easy
pointer to the option for anyone inquiring about the change.

On Sat, Jul 09, 2005 at 12:32:33PM +0200, Stefan Richter wrote:
> Ben Collins wrote:
> > Can we, instead of removing these, wrap then in a "Export full API" config
> > option? I've already got several reports from external projects that are
> > using most of these exported symbols, and I'd hate to make it harder on
> > them to use our drivers (for internal projects or otherwise).
> 
> OK, why not. Here is an alternative patch, split in two parts. The first
> part is independent of the second, although the 2nd motivates the 1st.
> 2nd part follows in a separate posting.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
