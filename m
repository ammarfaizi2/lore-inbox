Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVFLNRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVFLNRb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVFLNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:17:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:32780 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262479AbVFLNRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:17:11 -0400
Date: Sun, 12 Jun 2005 15:17:01 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andi Kleen <ak@muc.de>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       subbie subbie <subbie_subbie@yahoo.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: optional delay after partition detection at boot time
Message-ID: <20050612131701.GA8907@alpha.home.local>
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com> <20050612071213.GG28759@alpha.home.local> <Pine.LNX.4.62.0506121225170.11197@numbat.sonytel.be> <20050612110539.GA9765@gallifrey> <20050612111659.GH28759@alpha.home.local> <20050612125447.GD9765@gallifrey> <m1fyvnd8kc.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyvnd8kc.fsf@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 03:10:59PM +0200, Andi Kleen wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> >
> > 1) could be cured by not actually panic'ing.
> 
> Actually one thing I always wanted was to make sysrq still work 
> after panic. Then you could add a key to page through the dmesg
> there too and the problem would be solved.

Well, that's why I wrote kmsgdump several years ago :-) You could even print
the messages on a parallel printer or save them to a floppy disk.

> It would be extremly useful to reset remote servers when panic=timeout
> is not set, but something went wrong with mounting /.

I think that more generally, we should reset if there's no panic=timeout,
because the reasons for a panic are multiple and in case of remote servers,
it's always a nightmare to know that may be you will lose access after one
risky operation.

Willy

