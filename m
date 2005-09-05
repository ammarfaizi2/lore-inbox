Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVIEEsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVIEEsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 00:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVIEEsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 00:48:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28690 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932204AbVIEEsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 00:48:36 -0400
Date: Mon, 5 Sep 2005 06:48:09 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dave Jones <davej@redhat.com>, Alex Davis <alex14641@yahoo.com>,
       Sean <seanlkml@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: RFC: i386: kill !4KSTACKS
Message-ID: <20050905044809.GE30279@alpha.home.local>
References: <36918.10.10.10.10.1125889201.squirrel@linux1> <20050905034158.97152.qmail@web50213.mail.yahoo.com> <20050905042641.GD4715@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905042641.GD4715@redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Sep 05, 2005 at 12:26:41AM -0400, Dave Jones wrote:
(...)
> A lot of users look at it as nirvana. I've seen users report bugs against
> ancient kernels, that are extremely likely to be fixed in later kernels,
> yet they're unwilling to move to a newer kernel due to them being tied
> to a driver that only works on an older kernel, despite the fact that there
> are known security and data corruption issues with the older kernels.
> 
> Helping the cause of binary (or part binary) solutions doesn't solve anything.
> It brings nothing but unsolvable problems, and upset users when their problems
> can't get fixed.

The problem is not whether to support or not to support binary only drivers,
I personnally am fairly against such drivers and don't have any on any of my
systems. But the problem is that something that works in a *stable* series
kernel does not work anymore in the next *stable* series which should
theorically only fix bugs. And that's what upsets your users. As you said,
when you tell them to upgrade, they refuse because the only thing they need
to make their laptop work will not work anymore. So when they have spent
tens of hours of research on the net to find *a way* to install Linux on
their laptop with network support, they get used to it. When you tell them
that the upgrade will fix their oopses but will not support their network
card anymore, of course they don't want to upgrade ! And don't tell me that
they just have to by another card, I know users of laptops with only one
pcmcia slot, and this one does not work at all. But even with the oopses,
they are happy not to be forced to work in windows. You know, when they
proudly show me that Linux finally "works" on their laptop, and that they
had to install a ton of binary drivers and ndiswrapper, I whine a lot
telling them that it's not "Linux" they have installed, but sort of a
thing that will ressemble it and which will probably be even less stable
than windows. But they don't care, because they did not have choice.

Willy

