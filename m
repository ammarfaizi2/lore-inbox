Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269054AbTBXBQv>; Sun, 23 Feb 2003 20:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269055AbTBXBQv>; Sun, 23 Feb 2003 20:16:51 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:202 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S269054AbTBXBQt>;
	Sun, 23 Feb 2003 20:16:49 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Kenneth Johansson <ken@kenjo.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1046044629.2210.3.camel@irongate.swansea.linux.org.uk>
References: <E18moa2-0005cP-00@w-gerrit2>
	 <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	 <20030223082036.GI10411@holomorphy.com>
	 <b3b6oa$bsj$1@penguin.transmeta.com>
	 <1046031687.2140.32.camel@bip.localdomain.fake>
	 <16920000.1046033458@[10.10.2.4]>
	 <1046044629.2210.3.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1046050010.2840.14.camel@tiger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 02:26:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-24 at 00:57, Alan Cox wrote:
> On Sun, 2003-02-23 at 20:50, Martin J. Bligh wrote:
> > >> And the baroque instruction encoding on the x86 is actually a _good_
> > >> thing: it's a rather dense encoding, which means that you win on icache. 
> > >> It's a bit hard to decode, but who cares? Existing chips do well at
> > >> decoding, and thanks to the icache win they tend to perform better - and
> > >> they load faster too (which is important - you can make your CPU have
> > >> big caches, but _nothing_ saves you from the cold-cache costs). 
> > > 
> > > Next step: hardware gzip ?
> > 
> > They did that already ... IBM were demonstrating such a thing a couple of
> > years ago. Don't see it helping with icache though, as it unpacks between
> > memory and the processory, IIRC.
> 
> I saw the L2/L3 compressed cache thing, and I thought "doh!", and I watched and
> I've not seen it for a long time. What happened to it ?
> 

http://www-3.ibm.com/chips/techlib/techlib.nsf/products/CodePack

If you are thinking of this it dose look like people was not using it I
know I'm not.It reduces memory for instructions but that is all and
memory is seems is not a problem at least not for instructions. 

It dose not exist in new cpu's from IBM I don't know the official reason
for the removal.

If you really do mean compressed cache I don't think anybody has done
that for real.

