Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVGFVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVGFVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVGFUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:48:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63685 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262536AbVGFUs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:48:29 -0400
Date: Wed, 6 Jul 2005 13:48:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Mahoney <jeffm@suse.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       benh@kernel.crashing.org
Subject: Re: [PATCH 2/3 (updated)] openfirmware: add sysfs nodes for open
 firmware devices
In-Reply-To: <42CC4177.9020607@suse.com>
Message-ID: <Pine.LNX.4.58.0507061346440.4159@g5.osdl.org>
References: <20050706192627.GA17492@locomotive.unixthugs.org>
 <Pine.LNX.4.58.0507061241010.3570@g5.osdl.org> <Pine.LNX.4.58.0507061317250.4114@g5.osdl.org>
 <42CC4177.9020607@suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jul 2005, Jeff Mahoney wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Linus Torvalds wrote:
> > 
> > On Wed, 6 Jul 2005, Linus Torvalds wrote:
> >>Can you re-send the other ones too, and I'll apply the whole series.
> > 
> > Ok, I've applied it, but it seems to make my X installation really really 
> > unhappy on my G5.
> > 
> > I'm trying to hunt down the reason (no oopses, at least).
> 
> Hrm. These patches always get more fun. What behavior are you seeing?

The kernel works, everything is happy, but X sets a mode that apparently 
doesn't work out and my screen is all black.

However, I don't think it was your patches after all.  I'm still hunting, 
but it might even have been a totally unrelated "yum upgrade". 

		Linus
