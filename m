Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUHXANF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUHXANF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 20:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266836AbUHXAMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 20:12:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48012 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267527AbUHWTum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:50:42 -0400
Date: Mon, 23 Aug 2004 21:49:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kjartan Maraas <kmaraas@broadpark.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops on suspend/resume
Message-ID: <20040823194943.GA3013@openzaurus.ucw.cz>
References: <1092862850.7890.3.camel@home.gnome.no> <20040821075023.GA603@openzaurus.ucw.cz> <1093204951.4839.6.camel@home.gnome.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093204951.4839.6.camel@home.gnome.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I got this when trying out suspend/resume on a HP NC8000 laptop. The
> > > kernel is one of the latest from fedora development, 2.6.8-rc4-bk4 or
> > > something based.
> > 
> > Its not oops. Try disabling preempt.
> > 
> I guess there's no way to do that without recompiling the kernel,
> right? 
> 
> The bug is not entirely reproducable in the first place and I run into
> worse problems when I actually get the machine to suspend anyway. I have
> to remove the ehci-hcd and uhci-hcd modules before the machine goes to
> sleep, and there's no way to get it to resume so far.
> 
> I've disabled the config to shutdown when the power button is pressed so
> in theory it should resume when I hit it, but it doesn't...

You should really try latest 2.6.8.1-mm3 kernel and read the docs (Documentation/power/*)...

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

