Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTJUHWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 03:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbTJUHWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 03:22:12 -0400
Received: from dns1.seagha.com ([217.66.0.18]:40781 "EHLO relay-1.seagha.com")
	by vger.kernel.org with ESMTP id S262986AbTJUHWJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 03:22:09 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601177AEB@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Neil Brown'" <neilb@cse.unsw.edu.au>
Cc: Kevin Corry <kevcorry@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: RE: LVM on md0: raid0_make_request bug: can't convert block acros
	s chunks or bigger than 64k
Date: Tue, 21 Oct 2003 09:24:57 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Somebody else referred to this posting:
> >   http://marc.theaimsgroup.com/?l=linux-kernel&m=103369952814053&w=2
> > 
> > but that patch doesn't apply cleanly anymore and I'm not 
> familiar with
> > the code to be confident to fix it up myself. (that post 
> was from almost
> > exactly 1 year ago, so alot changed probably :)
> 
> That patch is already included.
> 
> The problem is that dm is not honouring the merge_bvec_fn that
> raid0 has set.
> 
> This patch might fix it, but I'm not very familiar with the dm code,
> so I make no promises.

I will give it a shot when I get home.

> (I wonder why you are running LVM on top of raid0 given that lvm
> contains raid0 functionality).
> 
> NeilBrown

Historical reasons.. but since it worked, I never changed it.. and now it
makes for a good test case :)

Thx,
Karl
