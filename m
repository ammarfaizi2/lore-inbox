Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131455AbRCNQ2B>; Wed, 14 Mar 2001 11:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131460AbRCNQ1v>; Wed, 14 Mar 2001 11:27:51 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44724 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131455AbRCNQ1o>;
	Wed, 14 Mar 2001 11:27:44 -0500
Date: Wed, 14 Mar 2001 11:26:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: alan@lxorguk.ukuu.org.uk, linus@transmeta.com, rhw@memalpha.cx,
        linux-kernel@vger.kernel.org, seberino@spawar.navy.mil
Subject: Re: [PATCH] Improved version reporting
In-Reply-To: <UTC200103141601.RAA189084.aeb@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0103141114170.4468-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001 Andries.Brouwer@cwi.nl wrote:

> > +o  Console Tools      #   0.3.3        # loadkeys -V
> > +o  Mount              #   2.10e        # mount --version
> 
> Concerning mount: (i) the version mentioned is too old,
> (ii) mount is in util-linux. Conclusion: the mount line
> should be deleted entirely.

Many systems have mount (and bsdutils) separated from util-linux
as a binary package. Built from the same source, indeed, but...

> Concerning Console Tools: maybe kbd-1.05 is uniformly better.
> I am not aware of any reason to recommend the use of console-tools.

Debian has console-tools with priority:required and kbd with priority:extra.
Take it with Yann Dirson...
						Cheers,
							Al

