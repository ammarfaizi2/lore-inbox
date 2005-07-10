Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVGJSks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVGJSks (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 14:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVGJSks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 14:40:48 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:32652 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261152AbVGJSko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 14:40:44 -0400
Date: Sun, 10 Jul 2005 11:40:12 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: zippel@linux-m68k.org, hbryan@us.ibm.com, akpm@osdl.org,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       miklos@szeredi.hu, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: share/private/slave a subtree - define vs enum
Message-Id: <20050710114012.5b007240.rdunlap@xenotime.net>
In-Reply-To: <1121019702.20821.17.camel@localhost>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
	<courier.42CEC422.00001C6C@courier.cs.helsinki.fi>
	<Pine.LNX.4.61.0507082108530.3728@scrub.home>
	<1120851221.9655.17.camel@localhost>
	<Pine.LNX.4.61.0507082154090.3728@scrub.home>
	<1121019702.20821.17.camel@localhost>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jul 2005 21:21:42 +0300 Pekka Enberg wrote:

| Hi Roman,
| 
| At some point in time, I wrote:
| > > Roman, it is not as if I get to decide for the patch submitters. I
| > > comment on any issues _I_ have with the patch and the authors fix
| > > whatever they want (or what the maintainers ask for).
| 
| On Fri, 2005-07-08 at 21:59 +0200, Roman Zippel wrote:
| > The point of a review is to comment on things that _need_ fixing. Less 
| > experienced hackers take this a requirement for their drivers to be 
| > included.
| 
| Hmm. So we disagree on that issue as well. I think the point of review
| is to improve code and help others conform with the existing coding
| style which is why I find it strange that you're suggesting me to limit
| my comments to a subset you agree with.
| 
| Would you please be so kind to define your criteria for things that
| "need fixing" so we could see if can reach some sort of an agreement on
| this. My list is roughly as follows:
| 
|   - Erroneous use of kernel API
|   - Bad coding style
|   - Layering violations
|   - Duplicate code
|   - Hard to read code

Those are all good points IMO, but there is little (or no)
concensus on "bad coding style" or "hard to read code".

Maybe it would make more sense to make some suggested changes to
Documentation/CodingStyle (in the form of a patch) and see what
kinds of reactions (support) it gets.

---
~Randy
