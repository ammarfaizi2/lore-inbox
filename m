Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280661AbRKBL57>; Fri, 2 Nov 2001 06:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280666AbRKBL5t>; Fri, 2 Nov 2001 06:57:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:54246 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280661AbRKBL5c>;
	Fri, 2 Nov 2001 06:57:32 -0500
Date: Fri, 2 Nov 2001 06:57:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: dalecki@evision.ag
cc: Rusty Russell <rusty@rustcorp.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
In-Reply-To: <3BE29401.157394A5@evision-ventures.com>
Message-ID: <Pine.GSO.4.21.0111020652070.12621-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Nov 2001, Martin Dalecki wrote:

> Bull shit. Standard policy is currently to keep crude old
> interfaces until no end of time. Here are some examples:

[snip]

Again, standard procedure for removal of user-visible API:
	* next devel and following stable branch - use of that API is
possible but produces a warning
	* devel branch after that - API removed.

The fact that nobody had even started that with procfs is a separate story.
But no matter what user-visible API changes we start now, the earliest point
when the old stuff can be removed is 2.7.

