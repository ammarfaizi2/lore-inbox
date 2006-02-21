Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWBUW5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWBUW5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWBUW5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:57:22 -0500
Received: from soundwarez.org ([217.160.171.123]:61165 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S964890AbWBUW5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:57:21 -0500
Date: Tue, 21 Feb 2006 23:57:18 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060221225718.GA12480@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140562261.11278.6.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> On Sun, 2006-02-19 at 17:02 -0800, Greg KH wrote:
> > If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> > start working for you again?
> 
> Okey dokey, bisecting with mrproper took little longer than expected but
> I found the bad changeset:
> 
> 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> Author: Kay Sievers <kay.sievers@suse.de>
> Date:   Fri Nov 11 06:09:55 2005 +0100
> 
>     [PATCH] remove mount/umount uevents from superblock handling

Upgrade HAL, it's too old for that kernel.

Kay
