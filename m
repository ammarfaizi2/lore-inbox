Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261859AbVAST2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261859AbVAST2B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 14:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVAST2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 14:28:01 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:58078 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261859AbVAST15 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 14:27:57 -0500
Date: Wed, 19 Jan 2005 20:27:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andreas Gruenbacher <agruen@suse.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kbuild 2/5] Dont use the running kernels config file by default
In-Reply-To: <1106160130.8642.46.camel@winden.suse.de>
Message-ID: <Pine.LNX.4.61.0501192022010.30794@scrub.home>
References: <20050118184123.729034000.suse.de>  <20050118192608.423265000.suse.de>
  <Pine.LNX.4.61.0501182106340.6118@scrub.home>  <1106157119.8642.25.camel@winden.suse.de>
  <Pine.LNX.4.61.0501191858060.30794@scrub.home> <1106160130.8642.46.camel@winden.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jan 2005, Andreas Gruenbacher wrote:

> Okay, more verbose then. On your machine which is running kernel version
> x you build kernel version y. You grab the version y kernel source tree,
> let's say a vendor tree, which has meaningful default configurations in
> arch/$ARCH/defconfig. The runnig kernel's configuration may also work
> for that kernel source tree, or it may not.

How is that more verbose?
Please provide an example config that worked under 2.4 but doesn't produce 
a reasonable result under 2.6.

> > So they should first try the 2.6 kernel provided by the distribution and 
> > then try compiling their own kernel. In this situation it's actually more 
> > likely that they produce a working kernel with the current behaviour, the 
> > defconfig is not a guarantee for a working kernel either.
> 
> You assume that the user is already running the kind of kernel he is
> trying to produce. Al least to me this assumption seems weird.

Why is that weird?

bye, Roman
