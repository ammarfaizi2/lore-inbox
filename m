Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUCPTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUCPTrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:47:21 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:21262 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261576AbUCPTqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:46:03 -0500
Date: Tue, 16 Mar 2004 19:45:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: TLD.rmk.(none) junk in BitKeeper logs where BK_HOST belongs?
Message-ID: <20040316194559.D7886@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040316184455.GA31710@merlin.emma.line.org> <20040316191454.GK17813@bitmover.com> <Pine.LNX.4.58.0403161132000.17272@ppc970.osdl.org> <20040316194153.GA15282@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040316194153.GA15282@merlin.emma.line.org>; from matthias.andree@gmx.de on Tue, Mar 16, 2004 at 08:41:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 08:41:54PM +0100, Matthias Andree wrote:
> On Tue, 16 Mar 2004, Linus Torvalds wrote:
> > He does it on purpose. Apparently there is some UK law that may make it 
> > illegal to export other peoples email addresses without express consent, 
> > so rmk corrupts them with a script..
> 
> Two notes:
> 1.
> This could be handled by only including patches of those people who
> consent to their address being published,

This requires me to keep a database of peoples addresses who have
consented.  No thanks, that's a huge overhead and waste of time.

> 2.
> The user does not have to give a routable mail address in
> BK_USER/BK_HOST, but he can set BK_HOST to whatever he wants.

Indeed, so I set BK_HOST to something else.

> If the whole corruption is intentional, then I'd suggest that RMK
> participates in the maintenance of the lk-changelog.pl aka. shortlog
> script.

Again, no thanks, I'm already busy enough as it is.

> I have no chance to resolve common names through
> google/lbdb/grep -r on the suspect source files unless the address is
> there. There are so many people called Jonas Larsson - how do I know if
> that fellow has a middle name?

Have a look in the changesets themselves - you'll find the line "Patch
from" in them, so you can pick out the real persons name from that -
even automatically via a suitable regexp.

Sorry for being so unco-operative on this issue, but I'm doing my best
already.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
