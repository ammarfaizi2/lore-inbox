Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTA2Mpm>; Wed, 29 Jan 2003 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265885AbTA2Mpm>; Wed, 29 Jan 2003 07:45:42 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:4761 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S265880AbTA2Mpm>;
	Wed, 29 Jan 2003 07:45:42 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15927.53028.905164.188407@harpo.it.uu.se>
Date: Wed, 29 Jan 2003 13:55:00 +0100
To: Andi Kleen <ak@suse.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-dcl2
In-Reply-To: <p73el6wyvz1.fsf@oldwotan.suse.de>
References: <1043794298.10153.241.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
	<1043798822.10150.318.camel@dell_ss3.pdx.osdl.net.suse.lists.linux.kernel>
	<p73el6wyvz1.fsf@oldwotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Stephen Hemminger <shemminger@osdl.org> writes:
 > 
 > > > . Lockless gettimeofday                 (Andi Kleen, me)
 > 
 > The original algorithm actually came from Andrea Arcangeli,
 > I just ported it from vsyscalls to do_gettimeofday.
 > 
 > > > . Performance monitoring counters for x86 (Mikael Pettersson)
 > 
 > Isn't that slightly redundant with oprofile?
 > They have different capabilities, but there is still much overlap.

They're _completely_ different. The overlap, if any, is miniscule. Trust me :-)
