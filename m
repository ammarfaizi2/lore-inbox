Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318018AbSIESTC>; Thu, 5 Sep 2002 14:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318020AbSIESTB>; Thu, 5 Sep 2002 14:19:01 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:17363 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S318018AbSIESTA>; Thu, 5 Sep 2002 14:19:00 -0400
Subject: Re: ip_conntrack_hash() problem
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Patrick Schaaf <bof@bof.de>
Cc: Andi Kleen <ak@suse.de>, Rusty Russell <rusty@rustcorp.com.au>,
       Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020905195547.A21899@oknodo.bof.de>
References: <1031210342.9785.159.camel@biker.pdb.fsc.net>
	<20020905115208.4D0A02C064@lists.samba.org>
	<20020905135440.A10805@wotan.suse.de>  <20020905195547.A21899@oknodo.bof.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Sep 2002 20:24:35 +0200
Message-Id: <1031250277.9785.175.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-09-05 um 19.55 schrieb Patrick Schaaf:
> As a short time fix, seeing that it's mostly even hash bucket counts
> that give a problem, I would still propose just making the bucket count
> the nearest odd number, i.e. basically htable_size |= 1 in the startup code.
> 
> I don't expect any user to notice such a miniscule change.

Well then, as most people seem to think this is the way to go, let's do
it, and hope that Rusty's patch will be ready for prime-time soon.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





