Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWCUNiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWCUNiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751711AbWCUNiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:38:18 -0500
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:55452 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751709AbWCUNiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:38:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 00:37:51 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <200603090036.49915.kernel@kolivas.org> <200603220013.15870.kernel@kolivas.org> <1142948000.7807.63.camel@homer>
In-Reply-To: <1142948000.7807.63.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220037.52258.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 00:33, Mike Galbraith wrote:
> On Wed, 2006-03-22 at 00:13 +1100, Con Kolivas wrote:
> > On Wednesday 22 March 2006 00:10, Mike Galbraith wrote:
> > > How long should Willy be able to scroll without feeling the background,
> > > and how long should Apache be able to starve his shell.  They are one
> > > and the same, and I can't say, because I'm not Willy.  I don't know how
> > > to get there from here without tunables.  Picking defaults is one
> > > thing, but I don't know how to make it one-size-fits-all.  For the
> > > general case, the values delivered will work fine.  For the apache
> > > case, they absolutely 100% guaranteed will not.
> >
> > So how do you propose we tune such a beast then? Apache users will use
> > off, everyone else will have no idea but to use the defaults.
>
> Set for desktop, which is intended to mostly emulate what we have right
> now, which most people are quite happy with.  The throttle will still
> nail most of the corner cases, and the other adjustments nail the
> majority of what's left.  That leaves the hefty server type loads as
> what certainly will require tuning.  They always need tuning.

That still sounds like just on/off to me. Default for desktop and 0,0 for 
server. Am I missing something?

Cheers,
Con
