Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135614AbREGIzM>; Mon, 7 May 2001 04:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136047AbREGIzD>; Mon, 7 May 2001 04:55:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32676 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135614AbREGIyv>;
	Mon, 7 May 2001 04:54:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15094.25285.410379.109719@pizda.ninka.net>
Date: Mon, 7 May 2001 01:54:29 -0700 (PDT)
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Jonathan Morton <chromi@cyberspace.org>,
        BERECZ Szabolcs <szabi@inf.elte.hu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
In-Reply-To: <15094.10942.592911.70443@pizda.ninka.net>
	<Pine.LNX.4.33.0105070823060.24073-100000@svea.tellus>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tobias Ringstrom writes:
 > But is it really specified in the C "standards" to be exctly zero or one,
 > and not zero and non-zero?

I'm pretty sure it does.

 > IMHO, the ?: construct is way more readable and reliable.

Well identical code has been there for several months just a few lines
away.

I've seen this idiom used in many places (even the GCC sources :-),
so I'm rather surprised people are seeing it for the first time.

Later,
David S. Miller
davem@redhat.com
