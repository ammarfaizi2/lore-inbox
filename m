Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbTF2A0H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 20:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265497AbTF2A0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 20:26:07 -0400
Received: from crack.them.org ([146.82.138.56]:1208 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S265489AbTF2A0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 20:26:05 -0400
Date: Sat, 28 Jun 2003 20:40:12 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030629004012.GA29476@nevyn.them.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3EFCC1EB.2070904@candelatech.com> <20030627.151906.102571486.davem@redhat.com> <3EFCC6EE.3020106@candelatech.com> <20030627.170022.74744550.davem@redhat.com> <20030628001954.GD18676@work.bitmover.com> <34700000.1056760028@[10.10.2.4]> <1056828052.6295.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056828052.6295.31.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 08:20:53PM +0100, Alan Cox wrote:
> On Sad, 2003-06-28 at 01:27, Martin J. Bligh wrote:
> > That's a trivial change to make if you want it. we just add a "reviewed"
> > / "certified" state between "new" and "assigned". Yes, might be a good 
> > idea.  I'm not actually that convinced that "assigned" is overly useful
> > in the context of open-source, but that's a separate discussion.
> 
> Most bugzilla's seem to use VERIFIED for this, and it means people who
> have better things to do can just pull bugs that are verified and/or
> tagged with "patch" in the attachments

GCC just calls this "UNCONFIRMED" vs. "NEW", which seems to work well. 
A lot of the maintainers don't look at Bugzilla at all, and a lot of
the rest filter out UNCONFIRMED.  A couple of interested (and
dumbfoundingly dedicated) people review and confirm bugs; that's less
possible with the Linux kernel, since bugs often require hardware to
reproduce, but the principle is still sound.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
