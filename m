Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319121AbSIDNVy>; Wed, 4 Sep 2002 09:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSIDNVy>; Wed, 4 Sep 2002 09:21:54 -0400
Received: from ns.suse.de ([213.95.15.193]:25352 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S319121AbSIDNVx>;
	Wed, 4 Sep 2002 09:21:53 -0400
Date: Wed, 4 Sep 2002 15:26:26 +0200
From: Andi Kleen <ak@suse.de>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Schaaf <bof@bof.de>,
       Andreas Kleen <ak@suse.de>
Subject: Re: ip_conntrack_hash() problem
Message-ID: <20020904152626.A11438@wotan.suse.de>
References: <1031142822.3314.116.camel@biker.pdb.fsc.net> <20020904125628.GB1720@naboo.lincon.Uni-Koeln.DE> <1031145854.3359.125.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1031145854.3359.125.camel@biker.pdb.fsc.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the hash function should be fixed, not the possible choice of
> hash sizes, if that is at feasible.
I also agree with Martin that it is better to fix the hash function in
this case. Restricting to magic hash table sizes looks like a bad hack.

-Andi
