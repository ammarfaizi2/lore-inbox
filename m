Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbTCLQC7>; Wed, 12 Mar 2003 11:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCLQC7>; Wed, 12 Mar 2003 11:02:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62738 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261749AbTCLQCz>; Wed, 12 Mar 2003 11:02:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Date: 12 Mar 2003 08:13:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4nmau$3d0$1@cesium.transmeta.com>
References: <20030312034330.GA9324@work.bitmover.com> <20030312041621.GE563@phunnypharm.org> <20030312085517.GK811@suse.de> <20030312032614.G12806@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030312032614.G12806@schatzie.adilger.int>
By author:    Andreas Dilger <adilger@clusterfs.com>
In newsgroup: linux.dev.kernel
> 
> Sadly, some people see the dark side of everything.  I don't see how making
> a CVS repository available with comments and an as-good-as-you-can-do-with-CVS
> equivalent of a BK changeset equals "locking the revision history into a
> proprietary format".  Yes, Larry said that this would allow him to change the
> BK file format to break compatibility with CSSC, but it is no more "locked
> away" now than before for those people who refuse to use BK.
> 
> Ironically, SCCS was a former "evil proprietary format" that was reverse
> engineered to get CSSC, AFAIK.  People are still free to update CSSC to
> track BK if they so choose.
> 
> Some people will just never be happy no matter what you give them.
> 

>From what I can gather, the question is very simple:

"Can we get our data out of BK into some kind of open format?"

It's an important question.  If the answer is "yes, but only the stuff
that can be mapped onto CVS" then that's a significant data loss, and
if BitMover changes the data format without documentation, then there
is no longer a way to get all the data out.

Presumably the CVS exporter could get augmented with some kind of
metadata export... perhaps an XML schema that describes how the
various points are to be linked or whatnot... it won't turn CVS into
BK overnight (so Larry can still sleep at night), but it would give
BitMover the freedom to change their data format.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
