Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTLVSgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLVSgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:36:06 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:45017 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S262092AbTLVSgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:36:04 -0500
Date: Mon, 22 Dec 2003 10:35:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: lot of VM problem with 2.4.23
Message-ID: <20031222183554.GN6438@matchmail.com>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, andrea@suse.de
References: <Pine.LNX.4.58L.0312211235010.6632@logos.cnet> <20031221150312.GJ25043@ovh.net> <20031221154227.GB1323@alpha.home.local> <20031221161324.GN25043@ovh.net> <Pine.LNX.4.58L.0312211643470.6632@logos.cnet> <20031221191431.GP25043@ovh.net> <Pine.LNX.4.58L.0312211832320.6632@logos.cnet> <20031221210917.GB4897@ovh.net> <20031221222338.GC1323@alpha.home.local> <20031222070344.GL1524@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222070344.GL1524@niksula.cs.hut.fi>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 09:03:44AM +0200, Ville Herva wrote:
> BTW, I have a box with 128MB ram and 512MB swap running 2.4.21-jam1 (it has
> the -aa vm). I can't shut it down cleanly, because trying it goes into
> endless loop trying to free memory when turning off swap. Nothing but
> alt-sysrq-b seems to work.
> 
> I don't know if there is a kernel memory leak, since all user level
> processes should be killed at that point, right? Unfortunately I didn't have
> time to dig deeper, as the box is in (sort of) production.

Maybe, it depends on your init scripts.  Does your distribution do a kill -9
of all processes before turning off swap?
