Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVCBXsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVCBXsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVCBXpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:45:17 -0500
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]:21414 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261254AbVCBXno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:43:44 -0500
Date: Wed, 2 Mar 2005 16:44:45 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <20050302225846.GK17584@marowsky-bree.de>
Message-ID: <Pine.LNX.4.61.0503021642120.25831@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
 <20050302225846.GK17584@marowsky-bree.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Lars Marowsky-Bree wrote:

> On 2005-03-02T14:21:38, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > We'd still do the -rcX candidates as we go along in either case, so as a 
> > user you wouldn't even _need_ to know, but the numbering would be a rough 
> > guide to intentions. Ie I'd expect that distributions would always try to 
> > base their stuff off a 2.6.<even> release.
> 
> If the users wouldn't even have to know, why do it? Who will benefit
> from this, then?
> 
> I think a better approach, and one which is already working out well in
> practice, is to put "more intrusive" features into -mm first, and only
> migrate them into 2.6.x when they have 'stabilized'.
> 
> This could be improved: _All_ new features have to go through -mm first
> for a period (of whatever length) / one cycle. 2.6.x only directly picks
> up "obvious" bugfixes, and a select set of features which have ripened
> in -mm. 2.6.x-pre releases would then basically "only" clean up
> integration bugs.
> 
> -mm would be the 'feature tree'. Of course, features which have matured
> in other eligible trees might also work; the key point is the two-stage
> approach and it doesn't matter whether the chaos stage has one or three
> trees, as long as it's not more than that.

Certainly -mm can be the feature tree, but i've noticed that not that many 
people run -mm aside from developers. Meaning that a fair number of bugs 
seep into Linus' tree before they get attended to. It would even be more 
effective if we could get more -mm user coverage. A Linus based odd number 
might be closer to that if we hope on people unwittingly running them.
