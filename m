Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVIMIbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVIMIbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 04:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVIMIbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 04:31:37 -0400
Received: from mail.autoweb.net ([198.172.237.26]:56218 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932442AbVIMIbg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 04:31:36 -0400
Date: Tue, 13 Sep 2005 04:31:27 -0400
From: Ryan Anderson <ryan@michonline.com>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, klive@cpushare.com,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git tag in localversion
Message-ID: <20050913083120.GG5276@mythryan2.michonline.com>
References: <20050912210836.GL13439@opteron.random> <d120d5000509121431765f52c8@mail.gmail.com> <20050912222137.GP13439@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050912222137.GP13439@opteron.random>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 12:21:37AM +0200, Andrea Arcangeli wrote:
> On Mon, Sep 12, 2005 at 04:31:24PM -0500, Dmitry Torokhov wrote:
> > I think this question better be addressed to Ian or Sam (Andrea, did
> > you pick a wrong entry from your address book?), adding them to CC...
> 
> hmm, if you're not the right person it means hg log -p has some
> problem... this changeset was submitted by you according to mercurial.

I submitted the "Auto Localversion" change (and a fix for the fact that
it doesn't auto-disappear on a tagged version like it is supposed to,
submitted 5 minutes ago).

Yes, the goal of this was to avoid overwriting similar, but different
versions, for those of us who are, too lazy to download patches,
but are willing to type "git pull origin && make oldconfig && make" on a
regular basis.

My suggestion would be to classify these wherever they would fall if the
-gXXXXXXXX wasn't present, as they fall into the same category.

They won't get as much testing, but if you see 5 or 10 of these in the
same category and -rc range, that's a good indication that a few people
are testing those kernels.

-- 

Ryan Anderson
  sometimes Pug Majere
