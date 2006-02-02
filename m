Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWBBWcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWBBWcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWBBWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:32:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27025 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932367AbWBBWcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:32:21 -0500
Date: Thu, 2 Feb 2006 17:31:56 -0500
From: Dave Jones <davej@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michael Loftis <mloftis@wgops.com>, David Weinehall <tao@acc.umu.se>,
       Doug McNaught <doug@mcnaught.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
       dtor_core@ameritech.net, James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <20060202223156.GK11831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>, Michael Loftis <mloftis@wgops.com>,
	David Weinehall <tao@acc.umu.se>, Doug McNaught <doug@mcnaught.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>, Valdis.Kletnieks@vt.edu,
	dtor_core@ameritech.net,
	James Courtier-Dutton <James@superbug.co.uk>,
	linux-kernel@vger.kernel.org
References: <20060120200051.GA12610@flint.arm.linux.org.uk> <5793EB6F192350088E0AC4CE@d216-220-25-20.dynip.modwest.com> <87slrio9wd.fsf@asmodeus.mcnaught.org> <25D702FB62516982999D7084@d216-220-25-20.dynip.modwest.com> <20060202121653.GI20484@vasa.acc.umu.se> <67A0AFFBC77C32B9DEE25EFA@dhcp-2-206.wgops.com> <20060202201008.GD11831@redhat.com> <20060202220519.GA8712@mars.ravnborg.org> <20060202221023.GJ11831@redhat.com> <20060202221922.GB8712@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202221922.GB8712@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 11:19:22PM +0100, Sam Ravnborg wrote:

 > > -rw-r--r--    1 davej    davej        1753 Dec 15 23:31 linux-2.6-bzimage.patch
 > > 
 > > To get around some gynamstics in the rpm spec, defining a seperate build target
 > > for every arch, we make every arch grok 'bzImage'. Fugly, but it keeps the
 > > spec cleaner to maintain.
 > 
 > Yup - seen it before. Did not like it.
 > Consistent use of KBUILD_IMAGE across relevant architectures should buy
 > you the same simplicity and a mergeable approach.

tbh, patches like this just sit there, as 'they just work', rarely need
rediffing, the benefit to other people of it being upstream are next to nil
(or someone else would've done it by now), and I'm more motivated to work on
real problems like finding out why we've 3 different flavours of slab corruption right now.

		Dave

