Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264208AbRFFWhX>; Wed, 6 Jun 2001 18:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264212AbRFFWhN>; Wed, 6 Jun 2001 18:37:13 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1438 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264208AbRFFWg7>;
	Wed, 6 Jun 2001 18:36:59 -0400
Date: Wed, 6 Jun 2001 18:36:57 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        "Matt D. Robinson" <yakker@alacritech.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <15134.43914.98253.998655@pizda.ninka.net>
Message-ID: <Pine.GSO.4.21.0106061832220.10233-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Jun 2001, David S. Miller wrote:

> This allows people to make proprietary implementations of TCP under
> Linux.  And we don't want this just as we don't want to add a way to
> allow someone to do a proprietary Linux VM.

	Erm... What stops those who want to do such implementations
from using AF_PACKET and handling the whole thing in userland?

