Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTLKIZg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTLKIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:25:36 -0500
Received: from [139.30.44.16] ([139.30.44.16]:53148 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264446AbTLKIZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:25:34 -0500
Date: Thu, 11 Dec 2003 09:25:24 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing HZ (patch for HZ > 1000)
In-Reply-To: <1071126929.5149.24.camel@idefix.homelinux.org>
Message-ID: <Pine.LNX.4.53.0312110923070.9239@gockel.physik3.uni-rostock.de>
References: <1071122742.5149.12.camel@idefix.homelinux.org>
 <1288980000.1071126438@[10.10.2.4]> <1071126929.5149.24.camel@idefix.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, my reasons may sound a little strange, but basically I'd be
> fine with HZ=1000 if it wasn't for that annoying ~1 kHz sound when the
> CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
> sound is at a frequency where the ear is much less sensitive. Anyway, I
> thought some people might be interested in high HZ for other (more
> fundamental) reasons, so I posted the patch.

=8-)
I'd guess a tickless kernel might be what you actually want. See e.g.

  http://sourceforge.net/projects/high-res-timers/

Tim
