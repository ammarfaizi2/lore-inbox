Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbTJUBwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 21:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTJUBwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 21:52:39 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:59576 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262583AbTJUBwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 21:52:38 -0400
Date: Mon, 20 Oct 2003 21:46:02 -0400
From: Ben Collins <bcollins@debian.org>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: marcelo.tosatti@cyclades.com.br, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: patch for 2.4.22 sbp2 hang when loaded with devices already connected
Message-ID: <20031021014602.GD866@phunnypharm.org>
References: <ord6csra7h.fsf@free.redhat.lsd.ic.unicamp.br> <orbrsba0eg.fsf@free.redhat.lsd.ic.unicamp.br> <20031021010610.GB866@phunnypharm.org> <or1xt79xr3.fsf@free.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <or1xt79xr3.fsf@free.redhat.lsd.ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 20, 2003 at 11:37:36PM -0200, Alexandre Oliva wrote:
> On Oct 20, 2003, Ben Collins <bcollins@debian.org> wrote:
> 
> > Please let me send the patch to Marcelo. I have to get this into our
> > repo, and merge things around back to Marcelo, else it makes things
> > harder later.
> 
> Sure, do however you prefer.  Sorry that I wasn't aware of the
> procedure, and this ws the first patch I've ever submitted for the
> kernel, woohoo! :-)
> 
> I just asked around where patches for 2.4 were supposed to be sent,
> and got Marcelo's e-mail.  Then I noticed another firewire-related
> patch mentioned in the same bug report in Red Hat's bugzilla, saw it
> had been posted to these two mailing lists, and thought I'd do that as
> well.
> 
> Thanks again, your help was extremely useful in nailing the problem
> down.

No problem. Generally, Marcelo is the right place for 2.4, but sometimes
it's better to filter things through the subsystem maintainer if at all
possible. For something trivial, I wouldn't have bothered asking to
redirect through me, but for something like this I want to make sure we
get on the same page, and that I test it out a little bit more (I hadn't
even tested this patch myself yet :)

Definitely thanks again for the help. This is the second bug recently
that I could not reproduce and it takes feedback and effort like you
gave me in order to track things down.

FYI, I checked, and this is a non-issue with our current 2.6 code (not
sure it's pushed to Linus yet) because we removed several points of
problems like this.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
