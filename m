Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUC3MRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbUC3MRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:17:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8835 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263624AbUC3MRq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:17:46 -0500
Date: Tue, 30 Mar 2004 07:19:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Lev Lvovsky <lists1@sonous.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
In-Reply-To: <35350CCA-81D4-11D8-A0A8-000A959DCC8C@sonous.com>
Message-ID: <Pine.LNX.4.53.0403300717440.5144@chaos>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291602340.2893@chaos> <1CD69E8E-81C9-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291644200.3114@chaos> <BB3FCEF5-81CB-11D8-A0A8-000A959DCC8C@sonous.com>
 <Pine.LNX.4.53.0403291659400.3272@chaos> <35350CCA-81D4-11D8-A0A8-000A959DCC8C@sonous.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004, Lev Lvovsky wrote:

>
> On Mar 29, 2004, at 2:10 PM, Richard B. Johnson wrote:
> > You didn't care to read what I said? I said to remove those sym-links.
> > They must be replaced by headers that were in-use around the time
> > the C library code was compiled, preferably the exact same headers.
> >
> > There must not be any sym-link in the /usr/include/... directories
> > pointing to any kernel headers. That way, you can add new kernels
> > without ever screwing up your compiler.
>
> Understood.  Incidentally, the glibc-kernheaders package included with
> RH 7.3 creates those files as symlinks, I'm sure however that they were
> there for the compilation of glibc.  The disconnect that I forsee, is
> that I will be running the 2.2.26 with kernel headers from a 2.4.x
> kernel - would this be the correct thing to do?

To be absolutely sure you don't end up making user-mode code that
doesn't work, I would remove those sym-links and replace them with
the actual headers that are known to work.

>
> I suppose I mirror the sentiments of DervishD on this from his post.
>
> -lev
>

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


