Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129890AbRBYGIW>; Sun, 25 Feb 2001 01:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129885AbRBYGIL>; Sun, 25 Feb 2001 01:08:11 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2043 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129881AbRBYGIG>;
	Sun, 25 Feb 2001 01:08:06 -0500
Date: Sun, 25 Feb 2001 01:08:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Wakko Warner <wakko@animx.eu.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: OK to mount multiple FS in one dir?
In-Reply-To: <20010206154616.A9875@animx.eu.org>
Message-ID: <Pine.GSO.4.21.0102250104530.24871-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Feb 2001, Wakko Warner wrote:

> > > > I found I could mount three partitions on /mnt
> > > 
> > > Yes.  New feature, appeared in the 2.4.0test series, or shortly before.
> 
> I have a question, why was this idea even considered?

	Direct request from HPA. Autofs can win from having that (mounting
atop of mountpoint). I'd rather live without that stuff, but back then it
looked like an OK idea - we could do that. There is a better solution for
original problem, but...

