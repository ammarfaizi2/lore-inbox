Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264081AbTCXDY0>; Sun, 23 Mar 2003 22:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264084AbTCXDY0>; Sun, 23 Mar 2003 22:24:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:31507
	"EHLO x30.random") by vger.kernel.org with ESMTP id <S264081AbTCXDYZ>;
	Sun, 23 Mar 2003 22:24:25 -0500
Date: Sun, 23 Mar 2003 22:35:05 -0500
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@redhat.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Jeff Garzik <jgarzik@pobox.com>,
       James Bourne <jbourne@mtroyal.ab.ca>, linux-kernel@vger.kernel.org,
       Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Stephan von Krawczynski <skraw@ithnet.com>, szepe@pinerecords.com,
       arjanv@redhat.com, Pavel Machek <pavel@ucw.cz>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324033505.GJ1449@x30.local>
References: <1240000.1048460079@[10.10.2.4]> <200303232319.h2NNJqs13257@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303232319.h2NNJqs13257@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 23, 2003 at 06:19:52PM -0500, Alan Cox wrote:
> > O(1) sched may be a bad example ... how about the fact that mainline VM
> > is totally unstable? Witness, for instance, the buffer_head stuff. Fixes
> > for that have been around for ages. 
> 
> On normal computers 2.4.21pre VM is very stable, in fact I dumped the
> rmap vm from -ac because its far better at the moment

If you want to go in full sync with the other vm fixes and improvements
in my tree I can send you the other remaining patches to apply (not
before the end of next week though), they works so well that I don't get
a single vm report for several months and I would like if they could
reach mainline too infact since they are over-time-refinement only,
nothing I would call major or very significant. Maybe if you merge them,
then Marcelo will merge them too?  most of them are easily mergeable by
just checking my ftp area, most start with 05_vm_ and they shouldn't be
very controversial. Andrew blessed them too, when he splitted them (he
only giveup on the "-rest" patch so that one is still very monolithic
sorry ;).

Andrea
