Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUDGI5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 04:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUDGI5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 04:57:38 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:44690 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261880AbUDGI5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 04:57:36 -0400
Date: Wed, 7 Apr 2004 10:57:33 +0200
From: David Weinehall <tao@acc.umu.se>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge
Message-ID: <20040407085733.GJ8130@khan.acc.umu.se>
Mail-Followup-To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200404070102.i3712nDe002647@eeyore.valparaiso.cl> <20040407013450.84365.qmail@web40512.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407013450.84365.qmail@web40512.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:34:50PM -0700, Sergiy Lozovsky wrote:
> 
> --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > 
> > Why do you think it has been 2 pages (8KiB) for as
> > long as I remember
> > (essentially forever in Linux), and it has taken a
> > _lot_ of work to shrink
> > it to 4KiB (- size of *current)?
> 
> I described the possible solution (virtual stack)
> which can easily take care of this problem for some
> subsystems, or am I wrong. If code doesn't allocate
> big buffers in stack my solution can make conversion
> of existing code possible without _lot_ of work. (I'm
> lazy - remember :-)

You know, to me the combination of lazy programmer rhymes poorly with
well-written code and security audits.

> What do you think about my solution? Despite some
> additional overhead, but I don't think that it is
> significant.

Personally, I think this proposal would be worthy for the
patch-of-the-month award.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
