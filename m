Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRKITbJ>; Fri, 9 Nov 2001 14:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280052AbRKITa7>; Fri, 9 Nov 2001 14:30:59 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:31756 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S280043AbRKITaq>; Fri, 9 Nov 2001 14:30:46 -0500
Date: Fri, 9 Nov 2001 14:30:40 -0500
From: Bill Davidsen <davidsen@deathstar.prodigy.com>
Message-Id: <200111091930.fA9JUeH26971@deathstar.prodigy.com>
To: tmills@ica.net
Subject: Re: Included NIC module in newly compiled 2.4.130 finds only the first of 3 NICs 3c509
X-Newsgroups: linux.dev.kernel,linux.kernel
In-Reply-To: <6LdG7.12321$Re4.1880126@news20.bellglobal.com>
Organization: Prodigy http://www.prodigy.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <6LdG7.12321$Re4.1880126@news20.bellglobal.com> you write:
>
>All my three 3c509 cards work correctly under the original 2.2X kernel,
>using the modules (eth0,eth1 eth2)
>
>I downloaded the new kernel 2.4.130 and compiled it up.
>I said YES "*" to add my NIC driver (3c509.0)
>New kernel compiled fine and "teddy" boots up fine.
>
>However the new kernel (which has 3c509.0 support in it) only finds the
>first 3c509, it says "Delayed initialization"
>on eth1 and eth2.
>
>Why doesn't the new kernel with built in support find multiple instances of
>my card??
>
>I ran depmod -a and created the /lib/modules/2.4.13 folder...still nada....
>Any ideas????

Well, I would try the 3c59x driver for starters, built as a module.
Source code claims that it does the 3c905 and I believe I have it
running on some of my servers which are behind a firewall and can't
readily be checked.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
