Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUL2VAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUL2VAT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbUL2VAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 16:00:19 -0500
Received: from dsl-209-183-20-75.tor.primus.ca ([209.183.20.75]:20608 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S261405AbUL2VAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 16:00:13 -0500
Date: Wed, 29 Dec 2004 15:59:40 -0500
From: William Park <opengeometry@yahoo.ca>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
       Andreas Unterkircher <unki@netshadow.at>
Subject: Re: waiting 10s before mounting root filesystem?
Message-ID: <20041229205940.GB3024@node1.opengeometry.net>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org,
	Andreas Unterkircher <unki@netshadow.at>
References: <20041227195645.GA2282@node1.opengeometry.net> <20041227201015.GB18911@sweep.bur.st> <41D07D56.7020702@netshadow.at> <20041229005922.GA2520@node1.opengeometry.net> <Pine.LNX.4.61.0412290231580.3528@dragon.hygekrogen.localhost> <20041229015622.GA2817@node1.opengeometry.net> <41D2A7BE.2030806@grupopie.com> <20041229191525.GA2597@node1.opengeometry.net> <41D306AF.1020500@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D306AF.1020500@grupopie.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2004 at 07:34:07PM +0000, Paulo Marques wrote:
> William Park wrote:
> >[...] I read Documentation/initrd.txt and I don't understand it.  If
> >I understand it right, I have to build a complete root filesystem
> >with all the stuffs necessary for mounting the second (real) root
> >filesystem.  If I'm loading the kernel from floppy, then I only have
> >200k to work with.  I'll try initrd.txt, step by step over the
> >holidays.
> 
> Yes, but if you use "nash" as a script parser and compile everything
> you need static with dietlibc or uClibc (or some other small libc
> replacement), 200k will be plenty to accomplish what you want. You'll
> probably be able to find pre-compiled binaries like these on the net,
> if you search for them.
> 
> Of course this is much more work than simply patch the kernel to wait
> a little, but with this training you'll be able to handle similar
> situations in the future were there is no patch to solve them.

I finally wrote a script to build 200MB root filesystem from Slackware
distribution (A, AP, N, X series).  And, now, you're telling me to build
a 200kB root filesystem?  I need beer...

-- 
William Park <opengeometry@yahoo.ca>
Open Geometry Consulting, Toronto, Canada
Linux solution for data processing. 
