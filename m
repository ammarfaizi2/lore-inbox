Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbUK3UDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUK3UDT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbUK3Tzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:55:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:14494 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262285AbUK3Twu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:52:50 -0500
Subject: Re: user- vs kernel-level resource sandbox for Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grendel@caudium.net
Cc: Peter Chubb <peter@chubb.wattle.id.au>, Jeff Dike <jdike@addtoit.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130023947.GI5378@beowulf.thanes.org>
References: <20041129101919.GB9419@beowulf.thanes.org>
	 <200411292000.iATK0qOF004026@ccure.user-mode-linux.org>
	 <16811.40687.892939.304185@wombat.chubb.wattle.id.au>
	 <20041130023947.GI5378@beowulf.thanes.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101840505.25628.105.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 30 Nov 2004 18:48:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-30 at 02:39, Marek Habersack wrote:
> per-process isn't enough. I specifically need something to limit the memory
> usage on a more global scale - per user ID or per process group or a similar
> way of grouping related processes. That's the only way to tame processes
> like apache. At this point the option I'm considering is Xen, unless I can
> find a userland solution to the problem...

I'd suggest playing with Xen - its very efficient and it really does
come close to perfect constraint for resources.
