Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbTCWU1L>; Sun, 23 Mar 2003 15:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263191AbTCWU1K>; Sun, 23 Mar 2003 15:27:10 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64690 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263190AbTCWU1F>; Sun, 23 Mar 2003 15:27:05 -0500
Date: Sun, 23 Mar 2003 20:38:03 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Robert Love <rml@tech9.net>, Martin Mares <mj@ucw.cz>,
       Alan Cox <alan@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Stephan von Krawczynski <skraw@ithnet.com>, Pavel Machek <pavel@ucw.cz>,
       szepe@pinerecords.com, arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030323203803.A12220@devserv.devel.redhat.com>
References: <20030323193457.GA14750@atrey.karlin.mff.cuni.cz> <200303231938.h2NJcAq14927@devserv.devel.redhat.com> <20030323194423.GC14750@atrey.karlin.mff.cuni.cz> <1048448838.1486.12.camel@phantasy.awol.org> <20030323195606.GA15904@atrey.karlin.mff.cuni.cz> <1048450211.1486.19.camel@phantasy.awol.org> <402760000.1048451441@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <402760000.1048451441@[10.10.2.4]>; from mbligh@aracnet.com on Sun, Mar 23, 2003 at 12:30:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 12:30:43PM -0800, Martin J. Bligh wrote:

> The distros inherently have a conflict of interest getting changes merged
> back into mainline ... it's time consuming to do, it provides them no real
> benefit (they have to maintain their huge trees anyway), and it actively
> damages the "value add" they provide.

I take a strong objection to this. I can't speak for all distros, but I
know that Red Hat has a strong preference to get things merged upstream as
soon as possible. I think you are absolutely wrong about the "no
real benefit" part and that you totally misunderstand what value add
distributions provide.

> If that's people's attitude ("you should use a vendor"), then we need a 
> 2.4-fixed tree to be run by somebody with an interest in providing 
> critical bugfixes to the community with no distro ties.

this is not about distros or vendors (yes IBM is a linux vendor too). at
all. Marcelo is in a tough position; either he releases an emergency
kernel with a patch applied that seems to have a few corner case issues,
or he starts to rush out 2.4.21 based on the current
2.4.21-pre codebase. Given that there are other bugs in 2.4.20
that makes people say "but THIS needs to be in too", I can see
that becoming a very fuzzy thing pretty quick. Apparantly Marcelo decided
to go for the "get 2.4.21 out soon" approach..... 

Greetings, 
    Arjan van de Ven
