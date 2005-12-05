Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVLEQDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVLEQDr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVLEQDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:03:47 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:38043
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751382AbVLEQDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:03:46 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Date: Sun, 4 Dec 2005 21:31:12 -0600
User-Agent: KMail/1.8
Cc: David Ranson <david@unsolicited.net>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
References: <20051203135608.GJ31395@stusta.de> <4391D335.7040008@unsolicited.net> <20051203175355.GL31395@stusta.de>
In-Reply-To: <20051203175355.GL31395@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512042131.13015.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 11:53, Adrian Bunk wrote:
> On Sat, Dec 03, 2005 at 05:17:41PM +0000, David Ranson wrote:
> > Steven Rostedt wrote:
> > >udev ;)
> > >
> > >http://seclists.org/lists/linux-kernel/2005/Dec/0180.html
> >
> > Ahh OK .. I don't use it, so wouldn't have been affected. That's one
> > userspace interface broken during the series, does anyone have any more?
>
> - support for ipfwadm and ipchains was removed during 2.6
> - devfs support was removed during 2.6
> - removal of kernel support for pcmcia-cs is pending
> - ip{,6}_queue removal is pending
> - removal of the RAW driver is pending

So what you're upset about is the feature removal scheduling mechanism, which 
usually gives a full year's warning, and the removal patch can be reversed 
into a feature addition patch you can maintain outside the tree if you really 
care?

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
