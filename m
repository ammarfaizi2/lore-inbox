Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSLGUAv>; Sat, 7 Dec 2002 15:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSLGUAv>; Sat, 7 Dec 2002 15:00:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18950 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264724AbSLGUAu>; Sat, 7 Dec 2002 15:00:50 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Proposed ACPI Licensing change
Date: Sat, 7 Dec 2002 20:07:38 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <astkea$6ej$1@penguin.transmeta.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com> <20021207002405.GR2544@fs.tum.de>
X-Trace: palladium.transmeta.com 1039291679 28105 127.0.0.1 (7 Dec 2002 20:07:59 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Dec 2002 20:07:59 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021207002405.GR2544@fs.tum.de>,
Adrian Bunk  <bunk@fs.tum.de> wrote:
>
>You can't forbid people to send GPL-only patches, so if a person doesn't
>want his patch under your looser license you can't enforce that he also
>releases it under your looser license.

That's true, but on the other hand we've had these dual-license things
before (PCMCIA has been mentioned, but we've had reiserfs and a number
of drivers like aic7xxx too), and I don't think I've _ever_ gotten a
patch submission that disallowed the dual license. 

In fact, I don't think I'd even merge a patch where the submitter tried
to limit dual-license code to a simgle license (it might happen with
some non-maintained stuff where the original source of the dual license
is gone, but if somebody tried to send me an ACPI patch that said "this
is GPL only", then I just wouldn't take it). 

I suspect the same "refuse to accept license limiting patches" would be
true of most kernel maintainers.  At least to me a choice of license by
the _original_ author is a hell of a lot more important than the
technical legality of then limiting it to just one license. 

So yes, dual-license code can become GPL-only, but not in _my_ tree. 

Somebody else can go off and make their own GPL-only additions, and
quite frankly I would find it so morally offensive to ignore the intent
of the original author that I wouldn't take the code even if it was an
improvement (and I've found that people who are narrow-minded about
licenses are narrow-minded about other things too, so I doubt it _would_
be an improvement). 

		Linus
