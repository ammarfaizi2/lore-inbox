Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268734AbUIHQIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268734AbUIHQIM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUIHQIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:08:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27285 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269045AbUIHQHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:07:13 -0400
Date: Wed, 8 Sep 2004 18:05:27 +0200
From: Jens Axboe <axboe@suse.de>
To: TazForEver@dlfp.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1
Message-ID: <20040908160527.GS2258@suse.de>
References: <1094655493.18454.23.camel@athlon> <20040908153439.GM2258@suse.de> <20040908155742.GA19335@elektroni.ee.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908155742.GA19335@elektroni.ee.tut.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08 2004, Petri Kaukasoina wrote:
> On Wed, Sep 08, 2004 at 05:34:39PM +0200, Jens Axboe wrote:
> > On Wed, Sep 08 2004, Benoit Dejean wrote:
> > > is it normal that 2.6.9-rc1 still leaks like hell when burning an audio
> > > CD ? i though this was fixed since 2.6.8.1
> > 
> > hmm no, it should not be. more details, please.
> 
> bio_uncopy_user-mem-leak-fix.patch and bio_uncopy_user-mem-leak.patch were
> not included in 2.6.9-rc1.

oh right you are, I forget that the -rc1 is already so old. so the
problem is expected, upgrade to latest -rc1-bkX and you'll be fine.

-- 
Jens Axboe

