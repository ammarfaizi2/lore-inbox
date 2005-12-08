Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbVLHG2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbVLHG2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 01:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbVLHG2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 01:28:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56265 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030472AbVLHG2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 01:28:52 -0500
Date: Thu, 8 Dec 2005 01:28:44 -0500
From: Dave Jones <davej@redhat.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208062844.GF28201@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051208050738.GE24356@redhat.com> <20051208052632.GF11190@wotan.suse.de> <20051208053302.GA28201@redhat.com> <1134022925.7235.28.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134022925.7235.28.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 04:22:05PM +1000, Nigel Cunningham wrote:

 > > Yep, I noticed it offers a maximum of 6 cpus on my way.
 > > As a sidenote, seems kinda funny (and wasteful maybe?), doing this
 > > on a lot of hardware that isn't hotplug capable. (Whilst I could
 > > disable cpu hotplug in my local build, this isn't an answer for
 > > a generic distro kernel).
 > 
 > Both suspend to disk (and suspend to ram?) implementations now depend on
 > hotplug_cpu to enable extra cpus, so there is at least one reason for
 > them to want hotplug support in a generic kernel.

You mean suspend -> plug in a new cpu -> resume transitions ?
That sounds *terrifying*.

		Dave

