Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbTGRRDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269978AbTGRRDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:03:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26542
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S267517AbTGRRDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:03:11 -0400
Date: Fri, 18 Jul 2003 19:18:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, mason@suse.com,
       riel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Bug Report: 2.4.22-pre5: BUG in page_alloc (fwd)
Message-ID: <20030718171808.GH3928@dualathlon.random>
References: <Pine.LNX.4.55L.0307150859130.5146@freak.distro.conectiva> <1058297936.4016.86.camel@tiny.suse.com> <Pine.LNX.4.55L.0307160836270.30825@freak.distro.conectiva> <20030718112758.1da7ab03.skraw@ithnet.com> <Pine.LNX.4.55L.0307180921120.6642@freak.distro.conectiva> <20030718145033.5ff05880.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718145033.5ff05880.skraw@ithnet.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 02:50:33PM +0200, Stephan von Krawczynski wrote:
> You need heavy NFS action and I/O load. Its the same box I use for

I wonder if it can be related to the nfs changes. I also had those nfs
changes in my tree previously, but most of them rejected (i.e. a -R
wouldn't clean it up) so there must be further or slightly different
changes in mainline pre6 compared to 21rc8aa1. It could be only an
editing thing though.

It would be very interesting if you could still reproduce w/o nfs (for
example replacing the nfs transfers temporarily with an rsync, that
would reduce the scope of the problem a lot).

Andrea
