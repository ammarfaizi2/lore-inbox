Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbUDDX3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUDDX3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:29:39 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:9871 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262924AbUDDX3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:29:38 -0400
Date: Sun, 4 Apr 2004 19:17:46 -0400
From: Ben Collins <bcollins@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Marcel Lanz <marcel.lanz@ds9.ch>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PANIC] ohci1394 & copy large files
Message-ID: <20040404231746.GX13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch> <20040404141339.GW13168@phunnypharm.org> <1081119623.1285.121.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081119623.1285.121.camel@gaston>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 09:00:24AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2004-04-05 at 00:13, Ben Collins wrote:
> > On Sun, Apr 04, 2004 at 04:16:00PM +0200, Marcel Lanz wrote:
> > > Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
> > > to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.
> > > 
> > > Has anyone similar problems ?
> > 
> > Known issue, fixed in our repo. I still need to sync with Linus once I
> > iron one more issue and merge some more patches.
> 
> Hi Ben !
> 
> I don't want to be too critical or harsh or whatever, but why don't you
> just send such fixes right upstream instead of stacking patches for a
> while in your repo ? From my experience, such "batching" of patches is
> the _wrong_ thing to do, and typically, there is a major useability
> issue with sbp2 that could have been "right" in 2.6.5 final and will not
> be (so we'll have to wait what ? 1 or 2 monthes more now to have a
> release kernel with a reliable sbp2)

Because the fix was pretty extensive and needed testing. It was
potentially more broken that the problem it was fixing. Sending untested
patches to Linus is far worse than batching a few up and pushing to him.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
