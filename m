Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUA2Umz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 15:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUA2Umy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 15:42:54 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:43212 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266362AbUA2Umx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 15:42:53 -0500
Date: Thu, 29 Jan 2004 21:42:50 +0100
From: David Weinehall <tao@acc.umu.se>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lindent fixed to match reality
Message-ID: <20040129204250.GL16675@khan.acc.umu.se>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <20040129193727.GJ21888@waste.org> <20040129201556.GK16675@khan.acc.umu.se> <yw1xr7xi1ojs.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xr7xi1ojs.fsf@kth.se>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 09:35:03PM +0100, Måns Rullgård wrote:
> David Weinehall <tao@acc.umu.se> writes:
> 
> >> b) (no -bs) "sizeof(foo)" rather than "sizeof (foo)"
> >
> > I can't really see the logic in this, though I know a lot of people do
> > it.  I try to stay consistent, thus I do:
> >
> > if ()
> > for ()
> > case ()
> > while ()
> > sizeof ()
> > typeof ()
> >
> > since they're all parts of the language, rather than
> > functions/macros or invocations of such.
> 
> What I fail to see here is why that should make a difference regarding
> whitespace before the parens.

All I'm trying to say, is that we should be consistent; most code
has:

if (), for (), case (), while ()

(and possibly sizeof foo, typeof foo)

but

sizeof(foo), typeof(foo)

which is what I dislike (consistancy is good.)


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
