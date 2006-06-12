Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWFLRgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWFLRgr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWFLRgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:36:47 -0400
Received: from ns0.rackplans.net ([65.39.167.209]:32944 "EHLO
	mtl.rackplans.net") by vger.kernel.org with ESMTP id S1750767AbWFLRgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:36:46 -0400
Date: Mon, 12 Jun 2006 13:37:46 -0400 (EDT)
From: Gerhard Mack <gmack@innerfire.net>
X-X-Sender: gmack@mtl.rackplans.net
To: jdow <jdow@earthlink.net>
cc: Bernd Petrovitsch <bernd@firmix.at>, davids@webmaster.com,
       linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
In-Reply-To: <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
Message-ID: <Pine.LNX.4.64.0606121331090.16348@mtl.rackplans.net>
References: <MDEHLPKNGKAHNMBLJOLKEEFGMHAB.davids@webmaster.com>
 <193701c68d16$54cac690$0225a8c0@Wednesday> <1150100286.26402.13.camel@tara.firmix.at>
 <00de01c68df9$7d2b2330$0225a8c0@Wednesday>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, jdow wrote:

> Date: Mon, 12 Jun 2006 01:23:30 -0700
> From: jdow <jdow@earthlink.net>
> To: Bernd Petrovitsch <bernd@firmix.at>
> Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
> Subject: Re: VGER does gradual SPF activation (FAQ matter)
> 
> From: "Bernd Petrovitsch" <bernd@firmix.at>
> 
> > On Sat, 2006-06-10 at 22:17 -0700, jdow wrote:
> > [...]
> > > that matter. It simply says, "When I went and looked at the guy's claimed
> > > mail source the spf record said he was who he said he was." Who vouches
> > 
> > No. SPF simply defines legitimate outgoing MTAs for a given domain.
> > Within a domain, it is up to the postmaster to allow/disallow address
> > forgery and for the rest of a world (to tell where legitimate email of
> > his domain comes from), the postmaster defines SPF records.
> > 
> > Bernd
> 
> And just recently we received a spate of spam that came from a domain
> that disappeared almost immediately. Domain names are cheap. They can
> vouch for the spam run. Then what happens to them doesn't matter. But
> the SPF record passes.
> 
> {^_-}   There Ain't No Such Thing As A Free Lunch.
>        Too many people think SPF is a free lunch.

Look at it from a mail admin's perspective.  The bounces are now going 
nowhere instead of some poor user's mailbox.  You have just cut the damage 
in half.

Innerfire.net used to be foraged as a spam sender every other month and 
gmack@innerfire.net so often that I still have procmail filters to 
redirect bounces to their own folder.  The thousands of messages I was 
getting was infuriating but it has been a very rare event since I setup 
SPF on my domain.

SPF may not filter spam much but if you set it to autofail you can reduce 
the risk for innocent mail admins.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
