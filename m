Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTJSXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbTJSXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 19:21:57 -0400
Received: from public1-brig1-3-cust85.lond.broadband.ntl.com ([80.0.159.85]:4279
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S262323AbTJSXV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 19:21:56 -0400
Date: Mon, 20 Oct 2003 00:21:55 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, riel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre VM regression?
In-Reply-To: <20031016133552.GD1348@velociraptor.random>
Message-ID: <Pine.LNX.4.58.0310200014330.17168@ppg_penguin>
References: <20031016132412.GB1348@velociraptor.random>
 <Pine.LNX.4.44.0310161028080.2388-100000@logos.cnet>
 <20031016133552.GD1348@velociraptor.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Andrea Arcangeli wrote:

>
> sure. I think I already explained there are downsides in disabling the
> oom killer for desktops where the offender task is normally the biggest
> one too, but those downsides aren't something I care about given the
> cases it gets right w/o it (i.e. huge-shm-SGA/mlock/oomdeadlocks). the
> oom killer can do the wrong decision too sometime, and more
> systematically as well.
>

 Any chance of getting the oom killer back as an option ?  On
2.4.23-pre7 I made the mistake of trying to print a high-resolution
photo (300ppi, A4 size) using ghostscript while I was in X.  I've only
got 128MB memory and about 256MB swap on that box, which obviously
wasn't enough (gs typically uses up to 300MB for a 200ppi A4 picture).
Only problem was that X got killed instead of gs, which left the box
unuseable.  Last time I saw the oom killer in action it actually saved
me from having to reboot.

Ken
-- 
Will code payroll for food.



