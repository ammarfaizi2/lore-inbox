Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267078AbSK2PBN>; Fri, 29 Nov 2002 10:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267079AbSK2PBN>; Fri, 29 Nov 2002 10:01:13 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:48048 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S267078AbSK2PBM>; Fri, 29 Nov 2002 10:01:12 -0500
Date: Fri, 29 Nov 2002 16:08:32 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.Uni-Trier.DE>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>, <alan@redhat.com>
Subject: Re: A new Athlon 'bug'.
In-Reply-To: <20021126194129.GA24152@suse.de>
Message-ID: <Pine.LNX.4.44.0211291554330.30552-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Dave Jones wrote:

> On Mon, Nov 25, 2002 at 10:34:47PM +0100, Pavel Machek wrote:
>  > What happens when bit is programed wrongly?
>
> The documentation I have says nothing other than "...platforms are more
> robust..." with the fix. It's purely a reliability thing, but as it's
> fiddling with the CPU clock, it's possible that it may *slightly*
> affect performance too.

hi!
maybe somone remembers that i hacked a little bit with the power saving
modes of the athlon processor. so far as i know, the clk_ctl register is
importand when the athlon processor comes back from acpi-c2 mode. in c2 he
is disconnected from the system bus and the internal clock is clocked
down. in some cases a false value in this register could prevent the
athlon processor to come back from c2 -> lockup of the machine or
something like it ...
(bug 11 of the athlon processor revision guide)

daniel


# Daniel Nofftz .......................... #
# Sysadmin CIP-Pool Informatik ........... #
# University of Trier(Germany), Room V 103 #

The resonable man adapts himself to the world. The unreasonable
man persists in trying to adapt the world to himself. It follows
that all progress depends on the unresaonable man.
                                        George Bernard Shaw

