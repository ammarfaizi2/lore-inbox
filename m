Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUCJEDZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 23:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCJEDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 23:03:24 -0500
Received: from jozlin.snap.net.nz ([202.37.101.35]:32456 "EHLO
	jozlin.snap.net.nz") by vger.kernel.org with ESMTP id S261942AbUCJEDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 23:03:18 -0500
Date: Wed, 10 Mar 2004 17:08:49 +1300 (NZDT)
From: Keith Duthie <psycho@albatross.co.nz>
To: Linus Torvalds <torvalds@osdl.org>
cc: Thomas Schlichter <thomas.schlichter@web.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix warning about duplicate 'const'
In-Reply-To: <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0403101627040.4005@loki.albatross.co.nz>
References: <200403090043.21043.thomas.schlichter@web.de>
 <20040308161410.49127bdf.akpm@osdl.org> <Pine.LNX.4.58.0403081627450.9575@ppc970.osdl.org>
 <200403090217.40867.thomas.schlichter@web.de> <Pine.LNX.4.58.0403081728250.9575@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Mar 2004, Linus Torvalds wrote:

> All that code was from early 2002 (around 2.4.9), so maybe somebody can
> find the full discussion on the linux-kernel archives from January 2002 or
> so?

The thread in which the "const typeof" was introduced appears to be
"[IDEA+RFC] Possible solution for min()/max() war" from August/September
2001, and const typeof appears to have been introduced by Peter Breuer.

The arguments appear to largely be about signedness at that point. Some
mention is made of how bad -Wsign-compare is.
-- 
Just because it isn't nice doesn't make it any less a miracle.
     http://users.albatross.co.nz/~psycho/     O-   -><-
