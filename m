Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbULaTgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbULaTgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbULaTgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 14:36:08 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:4876 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262147AbULaTgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 14:36:05 -0500
Date: Fri, 31 Dec 2004 20:32:47 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Steinmetz <ast@domdv.de>
Cc: William Park <opengeometry@yahoo.ca>,
       Paulo Marques <pmarques@grupopie.com>, Jesper Juhl <juhl-lkml@dif.dk>,
       linux-kernel@vger.kernel.org, Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041231193247.GQ17946@alpha.home.local>
References: <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com> <20041229191525.GA2597@node1.opengeometry.net> <41D306AF.1020500@grupopie.com> <20041229205940.GB3024@node1.opengeometry.net> <41D320F3.2010508@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D320F3.2010508@domdv.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 10:26:11PM +0100, Andreas Steinmetz wrote:
> William Park wrote:
> >I finally wrote a script to build 200MB root filesystem from Slackware
> >distribution (A, AP, N, X series).  And, now, you're telling me to build
> >a 200kB root filesystem?  I need beer...
> 
> You don't need beer, you need busybox. The smallest initrd I made with 
> busybox is 99kB (finds boot cdrom and sets up a ram disk as rootfs).

Hmmm... Since we have the equivalent function in slightly less than 7 kB in
Formilux, I think that I should document a bit more when I have some time so
that others can reuse it... I find it a shame to still need 99 kB to find a
CDROM, particularly when you need to put this on floppies.

Regards,
Willy

