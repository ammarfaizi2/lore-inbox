Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbUERBEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbUERBEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUERBEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:04:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56253 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261900AbUERBEX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:04:23 -0400
Date: Tue, 18 May 2004 02:04:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Norman Diamond <ndiamond@despammed.com>
Cc: Roland Dreier <roland@topspin.com>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kill off PC9800
Message-ID: <20040518010419.GX17014@parcelfarce.linux.theplanet.co.uk>
References: <5265auu3i1.fsf@topspin.com> <05af01c43c5a$786e6340$b7ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05af01c43c5a$786e6340$b7ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 06:59:49AM +0900, Norman Diamond wrote:
 
> Do you realize that Apple's market share is still less than NEC's?  And if
> you want to go back 10 years, NEC had about 90% of the PC market and they
> were all 9800 series.

So are you volunteering to maintain the port?  Maintainers are MIA; the
damn thing doesn't compile; all patches it gets are basically blind
ones ("we have that API change, this ought to take care of those drivers
and let's hope that possible mistakes will be caught by testers").
Considering the lack of testers (kinda hard to test something that
refuses to build), the above actually spells in one word: "bitrot".

Either somebody shows up and takes over the damn thing, or it's just a
dead weight that could as well be left in linux-2.6.6.tar.bz2 on
kernel.org and not propagated any further.  If at some later point
somebody will decide to resurrected, they can always pick it from
said tarball.
