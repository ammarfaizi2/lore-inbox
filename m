Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUFBDvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUFBDvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 23:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUFBDvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 23:51:05 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:24332 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S265108AbUFBDvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 23:51:00 -0400
To: Valdis.Kletnieks@vt.edu
Cc: FabF <fabian.frederick@skynet.be>,
       Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1086148031@astro.swin.edu.au>
Subject: Re:  why swap at all? 
In-reply-to: <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net>            <1086114982.2278.5.camel@localhost.localdomain> <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-13727-23491-200406021347-tc@hexane.ssi.swin.edu.au>
Date: Wed, 2 Jun 2004 13:50:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu said on Tue, 01 Jun 2004 15:02:48 -0400:
> --==_Exmh_482188856P
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, 01 Jun 2004 20:36:23 +0200, FabF said:
> 
> > I guess we have a design problem right here.We could add per-process
> > swappiness attribute.That swap thread becomes boring coz we're looking
> > globally what's going wrong locally.
> 
> Hmm.. do we need to worry about the same DoS issues we need to worry about with
> mlock and friends?  I know I can trust myself to not do stupid things to said
> flags on my laptop (well... not twice anyhow ;).  On the other hand, I have
> systems with clueless users, and the even more dangerous half-clued users.  And
> then I have a bunch of machines in our security lab, where Bad Things happen
> all the time... 

I do often get frustrated that the DoS card is brought up to kill a
potentially useful solution. I think there should be a flag in KConfig
saying "This machine will be a server"/"This machine will be mostly a
single user desktop machine". In the latter, you can enable all these
vm/etc heuristics that will help out mozilla/X/your favourite
bloat-ware, but potentially enable a DoS attack, and in the former,
you stay conservative.

I can't rememeber the situation that I was last annoyed by someone
saying "but what about a DoS?"...

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
Entropy requires no maintenance.
                -- Markoff Chaney
