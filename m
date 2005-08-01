Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVHAOje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVHAOje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbVHAOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:39:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262218AbVHAOia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:38:30 -0400
Subject: RE: AACRAID failure with 2.6.13-rc1
From: Mark Haverkamp <markh@osdl.org>
To: Mark Salyzyn <mark_salyzyn@adaptec.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Drab <drab@kepler.fjfi.cvut.cz>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <60807403EABEB443939A5A7AA8A7458B01792901@otce2k01.adaptec.com>
References: <60807403EABEB443939A5A7AA8A7458B01792901@otce2k01.adaptec.com>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 07:38:24 -0700
Message-Id: <1122907104.24183.8.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 07:44 -0400, Salyzyn, Mark wrote:
> Yes, please put the workaround into 2.6.13!

I have re-submitted the patch that I sent a couple weeks ago to James
and the linus-scsi mailing list.

Mark.
> 
> Sincerely -- Mark Salyzyn
> 
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org] 
> Sent: Friday, July 29, 2005 3:59 PM
> To: Salyzyn, Mark
> Cc: drab@kepler.fjfi.cvut.cz; linux-kernel@vger.kernel.org;
> markh@osdl.org
> Subject: Re: AACRAID failure with 2.6.13-rc1
> 
> "Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:
> >
> > Martin may be overplaying the performance angle.
> > 
> > A previous patch took the adapter from 64K to 4MB transaction sizes
> > across the board. This caused Martin's adapter and drive combination
> to
> > tip-over. We had to scale back to 128KB sized transactions to get
> > stability on his system. All systems handled the 4MB I/O size in our
> > tests, but the tests that were done some time ago were not performed
> > with the latest kernel, which contributed to a change in testing
> > corners.
> 
> Confused.  The above appears to indicate that we should put the
> workaround
> into 2.6.13, yes?
> 
-- 
Mark Haverkamp <markh@osdl.org>

