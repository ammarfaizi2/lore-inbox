Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263762AbUACSnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263771AbUACSnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:43:24 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:385 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263762AbUACSnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:43:23 -0500
Date: Sat, 3 Jan 2004 19:44:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Karel =?iso-8859-1?Q?Kulhav=FD?= <clock@twibright.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Compatibility of Nvidia NVNET driver license with GPL
Message-ID: <20040103184434.GD1080@elf.ucw.cz>
References: <20031231073101.A474@beton.cybernet.src> <3FF26E8A.5070806@pobox.com> <20031231114357.A318@beton.cybernet.src> <3FF2C86C.1030906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2C86C.1030906@pobox.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If you are serious about this, we have tons of good ideas, and tons of 
> suggestions on how to avoid bad ideas :)
> 
> OpenCores (http://www.opencores.org/) might be a good place to start, as 
> they already have a 10/100 ethernet MAC which is working, and has been 
> silicon'd:  http://www.opencores.org/projects/ethmac/  Full "source" for 
> the MAC is available, in VHDL I think.  OpenCores also has PCI VHDL and 
> other glue you may need.
> 
> You'll definitely want to implement autonegotiation.  It's a showstopper 
> without that.  And if it's not gigabit ethernet, it's already outdated. 
>  So it's a tough challenge.

AFAIK, Clock is developing
ethernet-over-infrared-over-300meters-of-air. It knows what is at the
other end, and probably does not need autonegotiation. It is probably
not going to be gigabit, either. [Current version that works is 10mbit
over ~300meters].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
