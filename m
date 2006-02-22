Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbWBVAsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbWBVAsl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 19:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWBVAsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 19:48:41 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:43404 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030288AbWBVAsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 19:48:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.16-rc4: known regressions
Date: Wed, 22 Feb 2006 11:46:58 +1100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221146.59708.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2006 11:34, Linus Torvalds wrote:
> On Tue, 21 Feb 2006, Andrew Morton wrote:
> > We.  Don't.  Do. That.
> >
> > Please either restore the old events so we can have a 6-12 month
> > transition period or revert the patch.
>
> I agree.
>
> This stupid argument of "HAL is part of the kernel, so we can break it" is
> _bogus_.
>
> The fact is, if changing the kernel breaks user-space, it's a regression.
> IT DOES NOT MATTER WHETHER IT'S IN /sbin/hotplug OR ANYTHING ELSE. If it
> was installed by a distribution, it's user-space. If it got installed by
> "vmlinux", it's the kernel.
>
> The only piece of user-space code we ship with the kernel is the system
> call trampoline etc that the kernel sets up. THOSE interfaces we can
> really change, because it changes with the kernel.

Sanity.

It would be a sad day when no distribution in existence can support the 
current kernel except for a bleeding edge source based thing upgraded daily.

Cheers,
Con
