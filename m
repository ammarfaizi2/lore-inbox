Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965163AbVI1Gpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965163AbVI1Gpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVI1Gpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:45:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:44625 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751058AbVI1Gpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:45:53 -0400
Date: Wed, 28 Sep 2005 08:46:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Paulo da Silva <psdasilva@esoterica.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange behaviour with SATA disks. Light always ON
Message-ID: <20050928064612.GL2811@suse.de>
References: <43374DDB.6090708@esoterica.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43374DDB.6090708@esoterica.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26 2005, Paulo da Silva wrote:
> Hi!
> I don't know if this is the right place to ask
> about this, or even if this is a problem at all.
> 
> Anyway I didn't find relevant information on
> this ...
> 
> I have just bought a new PC with two SATA drives.
> I had no problems to have them working,
> apparently fine except for one thing:
> After reading the kernel, the driver access light (led?)
> is always on!
> Is this normal? Why?

It's a bug in the ahci driver in the kernel, if you upgrade to a newer
kernel it is fixed there. The changeset of interest is:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=c0b34ad2956036cdba87792d6c46d8f491539df1;hp=9309049544935f804b745aa4dea043fb39b2bf2a

-- 
Jens Axboe

