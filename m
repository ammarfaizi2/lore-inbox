Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUAZCBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265331AbUAZCBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:01:32 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:16895 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265326AbUAZCBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:01:30 -0500
Date: Mon, 26 Jan 2004 03:01:23 +0100
From: David Weinehall <tao@debian.org>
To: Jens Axboe <axboe@suse.de>
Cc: Coywolf Qi Hunt <coywolf@lovecn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.0.39] put_last_free() defined, but not used
Message-ID: <20040126020123.GC20879@khan.acc.umu.se>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Coywolf Qi Hunt <coywolf@lovecn.org>, linux-kernel@vger.kernel.org
References: <401417A3.7000206@lovecn.org> <20040125222914.GB20879@khan.acc.umu.se> <20040125234348.GV2734@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125234348.GV2734@suse.de>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 12:43:48AM +0100, Jens Axboe wrote:
> On Sun, Jan 25 2004, David Weinehall wrote:
> > On Mon, Jan 26, 2004 at 03:23:15AM +0800, Coywolf Qi Hunt wrote:
> > > Hello,
> > > 
> > > In 2.0.39, the function put_last_free() in fs/file_table.c is defined, 
> > > but no longer get used.
> > > Should it be removed?
> > 
> > I might consider this for 2.0.41, not for 2.0.40.  Indeed it doesn't
> > seem to be used, but it might be used in some external file system.
> 
> The function was static.

Ohhh, failed to spot that.  Bummer, since I just uploaded 2.0.40-rc8.
Then again, with the quality my -rc's have been of lately, there will
probably be a 2.0.40-rc9 anyway.  Sigh.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
