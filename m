Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261589AbUL3KMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbUL3KMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUL3KMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 05:12:41 -0500
Received: from 80-219-198-150.dclient.hispeed.ch ([80.219.198.150]:58752 "EHLO
	xbox.hb9jnx.ampr.org") by vger.kernel.org with ESMTP
	id S261589AbUL3KMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 05:12:39 -0500
Subject: Re: ptrace single-stepping change breaks Wine
From: Thomas Sailer <sailer@scs.ch>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, the3dfxdude@gmail.com, mh@codeweavers.com,
       pouech-eric@wanadoo.fr, dan@debian.org, roland@redhat.com,
       linux-kernel@vger.kernel.org, wine-devel@winehq.com
In-Reply-To: <20041229201531.40a0144a.akpm@osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com>
	 <20041119212327.GA8121@nevyn.them.org>
	 <Pine.LNX.4.58.0411191330210.2222@ppc970.osdl.org>
	 <20041120214915.GA6100@tesore.ph.cox.net> <41A251A6.2030205@wanadoo.fr>
	 <Pine.LNX.4.58.0411221300460.20993@ppc970.osdl.org>
	 <1101161953.13273.7.camel@littlegreen>
	 <1104286459.7640.54.camel@gamecube.scs.ch>
	 <1104332559.3393.16.camel@littlegreen>
	 <1104348944.5645.2.camel@kronenbourg.scs.ch>
	 <5304685704122912132e3f7f76@mail.gmail.com>
	 <1104371395.5128.2.camel@gamecube.scs.ch>
	 <Pine.LNX.4.58.0412291807440.2353@ppc970.osdl.org>
	 <1104376558.5128.22.camel@gamecube.scs.ch>
	 <20041229201531.40a0144a.akpm@osdl.org>
Content-Type: text/plain
Organization: Supercomputing Systems AG
Date: Thu, 30 Dec 2004 11:09:53 +0100
Message-Id: <1104401393.5128.24.camel@gamecube.scs.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-29 at 20:15 -0800, Andrew Morton wrote:

> You can globally disable flex-mmap with
> 
> 	echo 1 > /proc/sys/vm/legacy_va_layout
> 
> Does it fix things?

Haven't tried. But setarch i386 -L /usr/bin/wine ... did fix it.

Tom


