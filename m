Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSFQEDP>; Mon, 17 Jun 2002 00:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFQEDN>; Mon, 17 Jun 2002 00:03:13 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44007 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316681AbSFQEDI>;
	Mon, 17 Jun 2002 00:03:08 -0400
Date: Mon, 17 Jun 2002 06:01:08 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.4.19-pre10-ac2: O(1) scheduler merge, -A3.
In-Reply-To: <1024284900.3090.44.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206170550370.2941-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 16 Jun 2002, Robert Love wrote:

> > like above, 2.5 is the reference base. Especially for 100% nonfunctional
> > things like this it makes no sense to apply them to 2.4-ac only. But i
> > agree that existing comment fixes should be forward ported into 2.5, i've
> > applied them to my tree.
> 
> I agree the changes are nonfunctional and thus not a big deal...but I
> didn't see a point in pushing erroneous changes onto 2.4-ac, whether
> they are in 2.5 or not.

My method is that the less differences in a merge, the better. I dont mind
if a few comment fixes are lost temporarily, they'll be noticed and
forward ported the minute they get zapped by the backport. (and i have
reviewed -ac for ac-only functional fixes, none existed.) This way the
actual code creation part of the backport was a few minutes work only -
the real work mostly involved reviewing the functional parts of the
changes.

	Ingo

