Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266754AbUGUWCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266754AbUGUWCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUGUWCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:02:42 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:10716 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S266754AbUGUWCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:02:41 -0400
Date: Wed, 21 Jul 2004 17:13:01 -0400
From: Ben Collins <bcollins@debian.org>
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721211301.GA15344@phunnypharm.org>
References: <20040721141524.GA12564@kroah.com> <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1BnIHx-0003Py-00@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 03:41:45PM +0100, Matthew Garrett wrote:
> Greg KH <greg@kroah.com> wrote:
> 
> >Ok, to test out the new development model, here's a nice patch that
> >simply removes the devfs code.  No commercial distro supports this for
> >2.6, and both Gentoo and Debian have full udev support for 2.6, so it is
> >not needed there either.  Combine this with the fact that Richard has
> >sent me a number of good udev patches to fix up some "emulate devfs with
> >udev" minor issues, I think we can successfully do this now.
> 
> The new Debian installer requires devfs on several architectures, even
> for 2.6 installs. That's unlikely to get changed before release.

What's keeping those architectures from switching to udev?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
